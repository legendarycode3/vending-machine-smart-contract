// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {VendingMachine} from "../src/VendingMachine.sol";

contract VendingMachineTest is Test {

    /*//////////////////////////////////////////////////////////////
                            STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    VendingMachine public vendingmachine;

     /// @notice Generating deterministic addresses
    address  buyerPurchasing = makeAddr("buyer");
    address public owner = makeAddr("owner");
    address public hacker = makeAddr("hacker");

    uint256 public constant STOCK_PRICE = 0.1 ether;
    uint256 public constant INITIAL_STOCKS = 500;



    /*//////////////////////////////////////////////////////////////
                            FUNCTIONS 
    //////////////////////////////////////////////////////////////*/
    function setUp() public {
        vm.prank(owner);

        // Deploy the VendingMachine contract, not the test contract
        vendingmachine = new VendingMachine();
    }



    /*//////////////////////////////////////////////////////////////
                            CONSTRUCTOR TESTS
    //////////////////////////////////////////////////////////////*/
    function testOwnerIsSetCorrectly() public {
        assertEq(vendingmachine.i_owner(), owner);
    }

    function testInitialStockState() public {
        assertEq(vendingmachine.availableStocks(), INITIAL_STOCKS);
    }



     /*//////////////////////////////////////////////////////////////
                            RESTOCK TESTS
    //////////////////////////////////////////////////////////////*/
    function testIfOwnerCanRestock() public {
        uint256 amountToRestock = 150;

        vm.prank(owner);
        vendingmachine.restock(amountToRestock);

        assertEq(vendingmachine.availableStocks(), INITIAL_STOCKS + amountToRestock);
    }

    function testRevertWhenNonOwnerRestock() public  {
        vm.prank(hacker);

         vm.expectRevert(VendingMachine.Only__OwnerRestocks.selector);
    
        vendingmachine.restock(50);
    }



    /*//////////////////////////////////////////////////////////////
                            PURCHASE TESTS (Buyer)
    //////////////////////////////////////////////////////////////*/
    function testIfBuyerCanPurchaseStock() public {
        uint256 purchaseAmount = 5;
        uint256 requiredCost = purchaseAmount * STOCK_PRICE;

        // Give buyer enough ETH
        vm.deal(buyerPurchasing, requiredCost);
        
        // Buyer purchases
        vm.prank(buyerPurchasing);
        vendingmachine.buyerPurchaseStocks{value: requiredCost}(purchaseAmount);

        // Check balances
        assertEq(vendingmachine.availableStocks(), INITIAL_STOCKS - purchaseAmount);
        assertEq(vendingmachine.s_stocksBalance(buyerPurchasing), purchaseAmount);
        assertEq(address(vendingmachine).balance, requiredCost);
    }


     function testIfBuyerCanPurchaseStocksWithRefund() public {
        uint256 purchaseAmount = 20;
        uint256 requiredCost = purchaseAmount * STOCK_PRICE;
        uint256 paymentMade = requiredCost + 0.2 ether; // Overpaid

        // Give buyer enough ETH
        vm.deal(buyerPurchasing, paymentMade);

         // Buyer purchases
        vm.prank(buyerPurchasing);
        vendingmachine.buyerPurchaseStocks{value: paymentMade}(purchaseAmount);

        assertEq(vendingmachine.availableStocks(), INITIAL_STOCKS - purchaseAmount);
        assertEq(address(vendingmachine).balance, requiredCost); // Contract keeps exact cost
        assertEq(buyerPurchasing.balance, 0.2 ether); // Buyer received refund
     }


     function testRevertWhenInsufficientPaymentByBuyer() public {
         uint256 purchaseAmount = 30;
        uint256 sentValue = (purchaseAmount * STOCK_PRICE) - 0.01 ether; // Underpaid

        // Give buyer  ETH
        vm.deal(buyerPurchasing, sentValue);

         // Buyer trying to now purchase 
        vm.prank(buyerPurchasing);

        vm.expectRevert(
            abi.encodeWithSelector(
                VendingMachine.Insufficient__Balance.selector, 
                sentValue, 
                purchaseAmount * STOCK_PRICE
            )
        );

        vendingmachine.buyerPurchaseStocks{value: sentValue}(purchaseAmount);

     }



    /*//////////////////////////////////////////////////////////////
                           WITHDRAWAL TEST
    //////////////////////////////////////////////////////////////*/
    function testIfOwnerCanWithdrawFunds() public { 
        // Setup a purchase so contract has funds
        uint256 purchaseAmount = 100;

        uint256 requiredCost = purchaseAmount * STOCK_PRICE;

        // Give buyer  ETH
        vm.deal(buyerPurchasing, requiredCost);

        vm.prank(buyerPurchasing);

        vendingmachine.buyerPurchaseStocks{value: requiredCost}(purchaseAmount);

        uint256 preOwnerBalance = owner.balance;
        
        // Owner withdraws
        vm.prank(owner);
        vendingmachine.withdraw();

        // Checks
        assertEq(address(vendingmachine).balance, 0);
        assertEq(owner.balance, preOwnerBalance + requiredCost);
    }


     function testRevertWhenNonOwnerWithdraws() public {
        // Give contract funds
        uint256 purchaseAmount = 330;
        
        //uint256 requiredCost = purchaseAmount * STOCK_PRICE;
    
        vm.deal(buyerPurchasing, purchaseAmount * STOCK_PRICE);

        // UnKnown Buyer trying to purchase now
        vm.prank(buyerPurchasing);
        vendingmachine.buyerPurchaseStocks{value: purchaseAmount * STOCK_PRICE}(purchaseAmount);

        vm.prank(hacker);
        vm.expectRevert(VendingMachine.Only__OwnerRestocks.selector);
        vendingmachine.withdraw();
    }


    function testRevertWhenNoFundsAvailableForWithdraw() public {
        vm.prank(owner);

        vm.expectRevert(VendingMachine.No__FundsAvailable.selector);

        vendingmachine.withdraw();
    }





}






