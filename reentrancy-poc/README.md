# Re-entrancy Proof of Concept

Please feel free to clone and learn about smart contract's reentrancy attack from this repository.

#### Concept Explanation

The `append()` function on `Target` contract allows you to increment the `uint256 myStorage` variable only 20 times. But we gonna make it increment more than 20 times 
(more than the maximum limit `maxSupply`). This idea was base on the implementation of the `onERC721Received` function on ERC721 Token Standard
which allow ERC721 Contract to callback to your base contract. The attacking model was set up for [Hashmask NFT Contract](https://etherscan.io/address/0xc2c747e0f7004f9e8817db2ca4997657a7746928#code). The idea was reentrancing `Target` again when it call the function back to us (`Attacker`). According my testing result, I can break the limit of the maximum calling which was a `maxSupply` for 190 times. Which means in case of Hashmask NFT Contract, we could break the limit of maximum NFT supply up to `MAX+190` tokens.

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
Use for testing the reentrancy attack which has been describe above.

```sh
npm run test
```


