# Re-entrancy Proof of Concept

Please feel free to clone and learn about smart contract's reentrancy attack from this repository.

### Getting Started
```sh
$ git clone https://github.com/nutchanonc/nft-contract-assignment
```

then

```sh
$ cd reentrancy-poc
```

#### Installing dependencies
```sh
npm i
```

#### Compile contracts
The script will compile contracts in `contracts/*.sol`

```sh
npm run compile
```

#### Running test
Use for testing the reentrancy attack which will be describe below

```sh
npm run test
```

#### Test explanation

`Target` contract allows you to to increment the `uint256 myStorage` variable only 20 times. But we gonna make it increment more than 20 times 
(more than the maximum limit `totalSupply`)
