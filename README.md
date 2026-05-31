# 🎰 Vending Machine Smart Contract

## 📌 Features
* ****Immutable Owner:**** The deployer becomes the owner permanently.
* ****Fixed Product Price:**** Transparent pricing , no manipulation after deployment.
* ****Initial Inventory:**** Contract itself acts as the inventory holder.
* ****Owner-Only Restocking:**** Only the machine owner can add inventory and prevents unauthorized stock inflation.
* ****Purchase Mechanism.**** Users can buy stocks/items via `buyerPurchaseStocks()`.
* ****Automatic Refunds:**** If a buyer sends too much ETH. The excess amount is refunded automatically.
* ****CEI Security Pattern:**** This significantly reduces reentrancy risk.
* ****Owner Withdrawal:**** Allows only owner to withdraw accumulated sales revenue. Owner can "Checks balance first" and it automatically reverts if no valid available amount .
* ****Gas-Efficient Custom Errors:**** Instead of "require statement", rather "custom error" is being implement. For Lower deployment cost and Lower execution cost.
* ****On-Chain Inventory Management:**** Inventory quantities are stored permanently on-chain.
* ****Stock Balance Tracking:**** Uses `mapping(address => uint256)` to track stock ownership for every address.
* ****Contract Inventory Wallet:**** The contract itself holds inventory using `address(this)`.
* ****Inventory Availability Check:**** Prevents purchases exceeding available stock.
* ****Buyer Ownership Recording:**** Purchased stock is assigned

## 🧠 Key Concepts Applied

## Why This Matters (Vending Machine Smart Contract)


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
