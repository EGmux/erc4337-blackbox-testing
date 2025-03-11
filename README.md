## Setup

### Run the following commands to update the dependencies 

```shell
forge install uniswap/v3-core
forge install uniswap/v3-periphery
forge install openzepellin/openzeppelin-contracts
```

### Run the following commands to update [ hevm ](https://hevm.dev/), the tool used for symbolic testing

```shell
wget https://github.com/ethereum/hevm/releases/download/release/0.54.2/hevm-x86_64-linux
chmod +x ./hevm-x86_64-linux
```
### Run the following command to build the project

```shell
forge build --ast
```

### Run the follwing command to test the project
```
./hevm-x86_64-linux test
```

## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

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

### Anvil

```shell
$ anvil
```

### Deploy

```shell
$ forge script script/Counter.s.sol:CounterScript --rpc-url <your_rpc_url> --private-key <your_private_key>
```

### Cast

```shell
$ cast <subcommand>
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```

