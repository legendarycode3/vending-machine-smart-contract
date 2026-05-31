// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;


/**
 * @title   Vending Machine
 * @author  LegendaryCode
 * @notice  A smart contract-powered vending machine system that enables seamless item purchases, real-time inventory control, and transparent blockchain-based transactions.
 */





contract VendingMachine {

      /*///////////////////////////////////////////////////////////////
                                STATE VARIABLES
    //////////////////////////////////////////////////////////////*/
    address public immutable i_owner;

    uint256 public constant STOCK_PRICE = 0.1 ether;

    uint256 public constant INITIAL_STOCKS = 500;

    mapping (address => uint256) public s_stocksBalance;



    /*///////////////////////////////////////////////////////////////
                              EVENTS
    //////////////////////////////////////////////////////////////*/
     // Events for tracking
    event StockRestocked(uint256 amount);
    event StockPurchased(address indexed buyer, uint256 amount, uint256 cost);
    event RefundIssued(address indexed buyer, uint256 amount);
    event FundsWithdrawn(uint256 amount);





    /*///////////////////////////////////////////////////////////////
                              ERRORS
    //////////////////////////////////////////////////////////////*/
    error Only__OwnerRestocks();
    error Insufficient__Balance(uint256 sent, uint256 required);
    error Insufficient__SnacksStock(uint256 available, uint256 required);
    error No__FundsAvailable();
    error Transaction__Failed();



    /*///////////////////////////////////////////////////////////////
                              MODIFIERS
    //////////////////////////////////////////////////////////////*/
    modifier onlyOwner() {
        if(i_owner != msg.sender){
            revert Only__OwnerRestocks();
        }
        _;
    }



    /*///////////////////////////////////////////////////////////////
                                FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    constructor() {
        i_owner = msg.sender;

        // Contract owns 500 items
        s_stocksBalance[address(this)] = INITIAL_STOCKS;
    }
    
    
    function restock(uint256 _amount) public onlyOwner  {

        s_stocksBalance[address(this)] += _amount;

        emit StockRestocked(_amount);
    }



    function buyerPurchaseStocks(uint256 _amount) public payable {
                // CHECKS
         // Calculate the required amount (amount * 0.1 ether)
        uint256 requiredAmount = _amount * STOCK_PRICE;

        if(msg.value < requiredAmount){
            revert Insufficient__Balance(msg.value, requiredAmount);
        }

        if (s_stocksBalance[address(this)] < _amount) {
            revert Insufficient__SnacksStock(s_stocksBalance[address(this)], _amount);
        }

                //  EFFECTS (State updates)
        // Reduce vending machine stock
        s_stocksBalance[address(this)] -= _amount;

        // Give stocks to buyer
        s_stocksBalance[msg.sender] += _amount;

        emit StockPurchased(msg.sender, _amount, requiredAmount);


                //  INTERACTIONS (External calls to transfer funds)
         // Handle refunds if the user overpaid (Refund excess ETH to buyer)
        if (msg.value > requiredAmount) {
            uint256 refund = msg.value - requiredAmount;
            
            // Send refund directly to the buyer
            (bool success, ) =  payable(msg.sender).call{value: refund}("");

            if (!success) {
                revert Transaction__Failed();
            }

            emit RefundIssued(msg.sender, refund);
        }
    }


    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;

        if(balance == 0) {
            revert No__FundsAvailable();

        }

        (bool success, ) = payable(i_owner).call{value: balance }("");
        if(!success){
           revert Transaction__Failed(); 
        }

         emit FundsWithdrawn(balance);
    }


    function availableStocks() public view returns(uint256) {
        return s_stocksBalance[address(this)];
    }

}






















