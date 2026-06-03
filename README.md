# 🎰 Vending Machine Smart Contract


## Project Overview
The `VendingMachine` smart contract is a blockchain-based inventory and payment system that simulates the functionality of a real-world vending machine. Users can purchase stocks/items by paying Ether, while the contract owner manages inventory through restocking and fund withdrawals. It is built on the Ethereum blockchain using Solidity. </br>
The contract leverages blockchain technology to provide transparent transactions, automated payment processing, immutable inventory tracking, and secure ownership controls.

****Project Objectives:**** </br>
The primary objectives of this project are: </br>
* Enable users to purchase items directly from a smart contract.
* Maintain an on-chain inventory system.
* Allow the owner to restock inventory when necessary.
* Automatically process payments and refunds.
* Ensure only authorized users can perform administrative actions.
* Demonstrate Solidity best practices such as:
  * Custom Errors.
  * Events.
  * Modifiers.
  * Checks-Effects-Interactions Pattern.
  * Immutable and Constant Variables.  

****Conclusion:**** </br>
This `Vending Machine Smart Contract` demonstrates a practical blockchain-based inventory and payment system. It combines secure ownership controls, transparent event logging, automated  refunds, and on-chain inventory management to create a decentralized vending machine solution. The project serves as an excellent example for core Solidity concepts while implementing real-world business logic in a smart contract environment.

## 📌 Features
* ****Immutable Owner:**** The deployer becomes the owner permanently.
* ****Fixed Product Price:**** Transparent pricing , no manipulation after deployment.
* ****Initial Inventory:**** Contract itself acts as the inventory holder.
* ****Owner-Only Restocking:**** Only the machine owner can add inventory and prevents unauthorized stock inflation.
* ****Purchase Mechanism.**** Users can buy stocks/items via `buyerPurchaseStocks()`.
* ****Automatic Refunds:**** If a buyer sends too much ETH. The excess amount is refunded automatically.
* ****CEI Security Pattern:**** This significantly reduces reentrancy risk.
* ****Owner Revenue Withdrawal:**** Allows only owner to withdraw accumulated sales revenue. Owner can "Checks balance first" and it automatically reverts if no valid available amount . Transfers all contract funds to the owner.
* ****Gas-Efficient Custom Errors:**** Instead of "require statement", rather "custom error" is being implement. For Lower deployment cost and Lower execution cost.
* ****On-Chain Inventory Management:**** Inventory quantities are stored permanently on-chain.
* ****Stock Balance Tracking:**** Uses `mapping(address => uint256)` to track stock ownership for every address.
* ****Contract Inventory Wallet:**** The contract itself holds inventory using `address(this)`.
* ****Inventory Availability Check:**** Prevents purchases exceeding available stock.
* ****Buyer Ownership Recording:**** Purchased stock is assigned to the buyer's balance.
* ****Public Inventory Query:**** Anyone can check available machine stock using `availableStocks()`.
* ****Secure Refund Transfer:**** Refunds are executed using low-level `.call()` for compatibility.
* ****Overpayment Detection:**** The contract identifies when a user sends more ETH than required.

## 🧠 Key Concepts Applied
* ****State Variables:**** Stores contract data such as owner address and stock balances.
* ****Mappings:**** `s_stocksBalance` maps addresses to stock quantities.
* ****Constructor**** Initializes ownership and starting inventory during deployment.
* ****Address Type:**** Used for ownership, balances, and fund transfers.
* ****Access Control:**** Restricts administrative actions to the contract owner.
* ****Modifiers:**** `onlyOwner` enforces permission checks.
* ****Custom Errors:**** Efficient error handling with lower gas consumption than strings.
* ****msg.sender:**** Identifies who is interacting with the contract.
* ****msg.value:**** Reads the amount of ETH sent in a transaction.
* ****Event Emission:**** Logs important activities on-chain.
* ****Low-Level Calls:**** Uses `.call{value: amount}("")` for ETH transfers.
* ****State Mutation:**** Updates balances during purchases and restocking.
* ****View Functions:**** `availableStocks()` reads data without modifying state.
* ****Public Visibility:**** Allows external access to variables and functions.
* ****Function Visibility:**** Uses `public` appropriately for user interaction.
* ****Gas Optimization Techniques:**** Custom errors, constants, and immutable variables reduce gas usage.
* ****Security-Oriented Design:**** Incorporates access control, validation, and safe transfer handling.
* ****Ether Units:**** Uses Solidity denomination `ether` for pricing.


## 📂 Project Structure (Files)
****1.**** ****`VendingMachine.sol`**** is the core smart contract of the project. It implements a blockchain-powered vending machine that maintains an inventory of stocks (items), allows users to purchase those stocks using Ether, automatically refunds excess payments, and enables the contract owner to manage inventory and withdraw funds. </br>
The contract demonstrates several important Solidity development concepts, including ownership management, inventory tracking, Ether transfers, event logging, custom errors, and smart contract security patterns. Also, this contract acts as the on-chain backend of the vending machine, ensuring that every transaction is executed according to predefined rules without the need for intermediaries. </br>

 Purpose: </br>
 The primary purpose of this file is to: </br>
  * Create a decentralized vending machine on the Ethereum blockchain.
  * Maintain inventory records directly on-chain.
  * Allow users to purchase stocks using Ether (ETH).
  * Enable the owner to manage inventory.
  * Securely store and transfer collected funds.
  * Provide transparency through blockchain event logs.
  * Demonstrate Solidity best practices and smart contract design patterns..

****2.**** ****`VendingMachine.t.sol`**** is the testing file responsible for validating the behavior and reliability of the smart contract. </br>
Built using Foundry's testing framework, this file contains a comprehensive suite of automated tests designed to simulate real-world interactions with the vending machine and verify that every function behaves correctly under both normal and abnormal conditions. </br>
Testing is essential because smart contracts become immutable after deployment, making bug prevention a critical development requirement. </br>

 Purpose: </br>
 The purpose of this file is to: </br>
   * Verify contract correctness.
   * Detect logic errors before deployment.
   * Confirm expected transaction behavior.
   * Ensure future code modifications do not introduce regressions.


## 🌐Technology Stack (Technologies Used)
* ****[Solidity](https://www.soliditylang.org/)**** - The programming language for writing the Smart contracts.
* ****[Remix IDE](https://remix.ethereum.org/)**** -  used it to write, and deploy the smart contract directly in the browser first. A fastest way to get started, acting as a "no-setup" workshop for smart contract development.
* ****[Foundry(forge, cast, anvil)](https://www.getfoundry.sh/)****  - Development framework and testing suite.
* ****[Visual Studio Code](https://code.visualstudio.com/)**** - Install this IDE only if you are using foundry development kit rather than "Remix IDE" which is for quick prototying.


## Getting Started
### Prerequisites
* Solidity Compiler, Version ^0.8.19 or higher.
* `Remix IDE` or  `Foundry Development Kit` 

### Recommendation (For Beginners)
****NOTE (Use Remix IDE, for quick prototyping):****  You can literally just copy the main contract source code and paste it on Remix IDE and learn along side how the code works while trying to build yours as you keep building.


## Usage 
### Building the Project (Using Remix IDE): 
1. Copy the core smart contract file code `VendingMachine.sol` to Remix IDE (a browser based IDE, for quick prototyping).
2. Create a new file for the project  on your Remix IDE and paste ,  to learn and build along faster.
3. And then Compile the smart  contract file you have created on Remix IDE.

### Building the Project  (Using Foundry Development Kit ) - only if you are good using foundry kit
1. Clone the repository:
   ```shell
      git clone https://github.com/legendarycode3/vending-machine-smart-contract
   ```
2. Navigate to the directory you created and cloned the file to:
   ```shell
      cd vending-machine-smart-contract
   ```
3. Compile the smart contract:  `forge build`

### Testing the contract (Using Foundry Development Kit )
Runing all tests:
   ```shell
        forge test
   ```
Runing specific test:
  ```shell
       forge test --mt testFunctionName
   ```


## 📋Contract Details
### Functions:
* ****`constructor()`****: Sets the contract deployer as the owner (`i_owner`) and initializes the vending machine with `500` stocks assigned to the contract itself (`address(this)`). </br>
  Purpose: </br>
    * Runs only once during deployment.
* ****`restock(uint256 _amount)`****: Allows only the owner to add more stocks to the vending machine inventory. Emits a `StockRestocked` event after successful restocking. </br>
    * Purpose: </br>
  Adds more inventory to the vending machine.
* ****`buyerPurchaseStocks(uint256 _amount)`****: Allows users to purchase stocks/items from the vending machine by sending ETH. Checks sufficient payment and inventory, transfers stocks to the buyer, issues refunds for overpayments, and emits purchase/refund events. </br>
    * Purpose: </br>
    Allows users to buy stocks from the vending machine.
* ****`withdraw()`****: Allows only the owner to withdraw all ETH accumulated in the contract from stock purchases. Reverts if there are no funds available. Emits a `FundsWithdrawn` event. </br>
    * Purpose: </br>
    Transfers all ETH stored in the contract to the owner.
* ****`availableStocks()`****: Returns the current number of stocks/items available in the vending machine inventory (`address(this)`). </br>
    * Purpose: </br>
    Returns the remaining inventory in the vending machine.
 
### Variables: 
* ****`i_owner`****: Stores the address of the contract owner (the deployer). It is set once in the constructor and cannot be changed afterward because it is `immutable`. </br>
    * Purpose: </br>
    Identifies the owner of the contract. </br>
    Used for access control through the `onlyOwner` modifier.
* ****`STOCK_PRICE`****: The fixed price of one stock/item in the vending machine. Set to `0.1 ether`. Since it is `constant`, its value cannot be modified. </br>
    * Purpose: </br>
    Defines the cost of one stock/item. </br>
* ****`INITIAL_STOCKS`****: Defines the initial inventory of the vending machine when the contract is deployed. Set to `500`. </br>
    * Purpose: </br>
    Sets the vending machine's starting inventory.
* ****`s_stocksBalance`****: Tracks the number of stocks/items owned by each address. The vending machine's inventory is stored under `address(this)`, while purchased stocks are stored under the buyer's address. </br>
    * Purpose: </br>
    Records stock ownership for every address.



## Usage Guide (How to use - `E.G When using Remix IDE`) - Workflow
### Deployment
****1.**** Compilie contract. </br>
****2.**** Deploy contract. </br>
****3.**** Deployer becomes owner. </br>
****4.**** Inventory automatically starts at 500 stocks. </br>

### Purchase Flow
****1.**** User selects quantity amunt. </br>
****2.**** Sends ETH with transaction. </br>
****3.**** Contract validates payment. </br>
****4.**** Inventory is reduced. </br>
****5.**** User balance increases. </br>
****6.**** Excess ETH is refunded. </br>

### Restocking Flow
****1.**** Owner calls `restock()`. </br>
****2.**** Inventory increases. </br>
****3.**** Event emitted. </br>

###  Withdrawal Flow
****1.**** Owner calls `withdraw()`. </br>
****2.**** Contract transfers accumulated ETH. </br>
****3.**** Event emitted.

## Why This Matters (Vending Machine Smart Contract)
The Vending Machine smart contract is important because it demonstrates the fundamental pillars of Web3. Here is why Vending Machine smart contracts are critical to the Web3 ecosystem:
* ****Decentralization:**** No central server controls transactions.
* ****Transparency:**** All actions are publicly visible.
* ****Demonstrates Trustless Transactions:**** Buyers interact directly with code instead of relying on a central authority to process purchases.
* ****Showcases Smart Contract Automation:**** Business rules are executed automatically without human intervention.
* ****Provides a Foundation  for Web3 Marketplaces:**** The same purchasing logic can be expanded into NFT, gaming, and e-commerce platforms.
* ****Demonstrates Digital Ownership:**** Ownership records are stored transparently on the blockchain.
* ****Demonstrates Blockchain-Based Accounting:**** Inventory and payments are automatically recorded and tracked.
* ****Programmability:**** money and assets follow automated rules.
* ****Ownership:**** Uers directly control their assets.
* ****Security:**** Blockchain consensus protects transaction integrity.
* ****Composability:**** the contract can become part of larger Web3 ecosystems.

## Benefits of Vending Machine Smart Contracts
Benefits of `Vending Machine Smart Contracts` (smart contracts that automatically execute predefined actions when conditions are met, similar to how a vending machine dispenses a product after payment): </br>
* ****Decentralization:**** No single authority controls the contract or transaction process.
* ****Permissionless Access:**** Anyone with a compatible wallet can interact with the contract.
* ****Token Integration:****  Supports cryptocurrencies, NFTs, and other digital assets natively.
* ****Programmable Money:**** Funds can be automatically distributed according to predefined rules.
* ****Reduced Counterparty Risk:**** Execution does not depend on a party keeping their promise.
* ****Cross-Border Transactions:**** Enables seamless transactions across countries without traditional banking delays.
* ****Enhanced Ownership Control:**** Users maintain direct control of their digital assets through their wallets.
* ****Instant Settlement:**** Assets are transferred and settled automatically when conditions are met.
* ****On-Chain Verification:**** Transactions and contract execution can be verified publicly on the blockchain.
* ****Censorship Resistance:**** Harder for a central authority to block or interfere with transactions.
* ****Fractional Ownership Support:**** Allows assets to be divided into smaller ownership units using tokens.
* ****Liquidity Enhancement:**** Digital assets can be traded or exchanged more efficiently in Web3 ecosystems.
* ****Automation:**** Transactions execute automatically without human intervention.
* ****Trustless Operation:**** Parties do not need to trust each other; they trust the code.
* ****Speed:**** Agreements are executed instantly once conditions are satisfied.
* ****Cost Reduction:**** Eliminates intermediaries such as brokers, agents, or lawyers for many transactions.
* ****Transparency:**** Contract terms and transaction records can be visible and verifiable on the blockchain.
* ****Security:**** Blockchain cryptography helps protect against tampering and unauthorized changes.
* ****Accuracy:**** Automated execution reduces human errors in processing agreements.
* ****Reliability:**** Once deployed, the contract follows predefined rules consistently.
* ****Immutability:**** Contract records are difficult to alter after being recorded on the blockchain.
* ****24/7 Availability:****  Contracts can execute at any time without dependence on business hours.
* ****Auditability:**** Every transaction can be tracked and verified through the blockchain ledger.
* ****Global Accessibility:**** Users from different locations can interact with the contract without geographic barriers.
* ****Verifiable Fairness:**** Contract logic can be inspected and audited by anyone before use.
* ****Scalability of Business Logic:**** The same contract can serve thousands or millions of users consistently.
* ****DAO Compatibility:****
* ****Micropayment Support:****
* ****Fractional Ownership Support:****
* ****Oracle Connectivity:****



## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of (Some include):

- **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).

## Documentation

https://book.getfoundry.sh/

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

## Author
Built with ❤️ by [@legendarycode3](https://github.com/legendarycode3/)  </br>
Part of my  `60 Days of Solidity Challenge`

##  If you find this project helpful,  link back to this repository. 
`I Appreciate`
