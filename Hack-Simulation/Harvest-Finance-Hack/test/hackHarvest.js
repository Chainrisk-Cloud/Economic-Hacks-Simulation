const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("HarvestFinance", function () {
    it("Run HarvestFinance exp", async function () {
        const Contract = await ethers.getContractFactory("ContractTest");
        const contract = await Contract.deploy();
        await contract.deployed();
        await contract.testExploit();
    });
});