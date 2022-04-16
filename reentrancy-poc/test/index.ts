import { expect } from "chai";
import { ethers } from "hardhat";

describe("The contract `Attacker` attacks `Target` by using re-entrancity.", function () {

  it("Could attack `Target`", async function () {
    // Deploying target contract
    const Target = await ethers.getContractFactory("Target");
    const target = await Target.deploy();
    await target.deployed();

    // Deploying attackr contract
    const Attacker = await ethers.getContractFactory("Attacker");
    const attacker = await Attacker.deploy();
    await attacker.deployed();

    await attacker.startAttacking(target.address);
    // console.log(await target.getLength());

    // expected the reentrancy to increment the `uint256 myStorage`
    // up to the answer (more than 20) 
    expect(await target.getLength()).to.above(0);
  });

  it("Should attack `Target` properly", async function () {
    // Deploying target contract
    const Target = await ethers.getContractFactory("Target");
    const target = await Target.deploy();
    await target.deployed();

    // Deploying attackr contract
    const Attacker = await ethers.getContractFactory("Attacker");
    const attacker = await Attacker.deploy();
    await attacker.deployed();

    await attacker.startAttacking(target.address);
    // console.log(await target.getLength());

    // The expected result is the result of the summation from 1 to 20
    // which is equal to 210;
    let answer = 0;
    for (var i=1; i<=20; i++) {
      answer += i;
    }
    // expected the reentrancy to increment the `uint256 myStorage`
    // up to the answer (more than 20) which is the maximum supply that
    // this contract can be called.
    expect(await target.getLength()).to.equal(answer);
  });
});
