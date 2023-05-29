const { loadFixture } = require("@nomicfoundation/hardhat-network-helpers");
const { expect } = require("chai");
const { ethers, waffle } = require("hardhat");

describe("Fantoon AI", function () {
    const approveAmount = "0xfffffffffffffffffffffffffffff";

    let owner, addr1, addr2, addr3, addr4;
    let DiamondToken, diamondToken;
    let FantoonAI, fantoonAI;
    let PK, pk, BK, bk, SK, sk;

    it("Deploying Diamond Token", async function () {
        DiamondToken = await ethers.getContractFactory("Diamond");
        diamondToken = await DiamondToken.deploy();
        await diamondToken.deployed();
    });

    it("Deploying pumpkittenNFT", async function () {
        PK = await ethers.getContractFactory("Pumpkittens");
        pk = await PK.deploy();
        await pk.deployed();
    });

    it("Deploying bitkittenNFT", async function () {
        BK = await ethers.getContractFactory("Bitkittens");
        bk = await BK.deploy(pk.address);
        await bk.deployed();
    });

    it("Deploying samuraikittenNFT", async function () {
        SK = await ethers.getContractFactory("Samuraikittens");
        sk = await SK.deploy(pk.address);
        await sk.deployed();
    });

    it("Deploying fantoonAI contract", async function () {
        FantoonAI = await ethers.getContractFactory("FantoonAI");
        fantoonAI = await FantoonAI.deploy();
        await fantoonAI.deployed();
    });

    it("Getting signers", async function () {
        [owner, addr1, addr2, addr3, addr4] = await ethers.getSigners();
    });

    it("Minting PumpkittenNFT to owner", async function () {
        var tx = await pk.connect(owner).setMintReservedTokenPeriod(0);
        await tx.wait();
        let price = await pk.getPrice();
        console.log("Price:",price);
        tx = await pk
            .connect(owner)
            .buyPumpkittens({ value: price });
        await tx.wait();
    });

    it("Minting PumpkittenNFT to addr1", async function () {
        var tx = await pk.connect(owner).setMintReservedTokenPeriod(0);
        await tx.wait();
        let price = await pk.getPrice();
        console.log("Price:",price);
        tx = await pk
            .connect(addr1)
            .buyPumpkittens({ value: price });
        await tx.wait();
    });

    it("Minting SamuraikittenNFT to addr1", async function () {
        var tx = await sk.connect(owner).setMintReservedTokenPeriod(0);
        await tx.wait();
        tx = await sk
            .connect(addr1)
            .buyKittens({ value: ethers.utils.parseEther("0.449") });
        await tx.wait();
    });

    it("Minting BitkittenNFT to addr1", async function () {
        var tx = await bk.connect(owner).setMintReservedTokenPeriod(0);
        await tx.wait();
        tx = await bk
            .connect(addr1)
            .buyKittens({ value: ethers.utils.parseEther("0.01") });
        await tx.wait();
    });

    it("Setting token", async function () {
        var tx = await fantoonAI.setToken(
            diamondToken.address,
            ethers.utils.parseEther("50")
        );
        await tx.wait();
    });

    // Set requisites to the fantoonAI contract
    it("Setting conditions", async function() {
        tx = await fantoonAI.addRequisite("Pumpkitten & Diamond 100", pk.address, 1, diamondToken.address, ethers.utils.parseEther("100"));
        await tx.wait();
        tx = await fantoonAI.addRequisite("Samurai & Diamond 500", sk.address, 1, diamondToken.address, ethers.utils.parseEther("500"));
        await tx.wait();
        tx = await fantoonAI.addRequisite("Bitkitten & Diamond 500", bk.address, 1, diamondToken.address, ethers.utils.parseEther("500"));
        await tx.wait();
        tx = await fantoonAI.addRequisite("Diamond 1000", ethers.constants.AddressZero, 0, diamondToken.address, ethers.utils.parseEther("1000"));
        await tx.wait();
    });

    it("Transfering 100 token to addr1", async function () {
        tx = await diamondToken.transfer(
            addr1.address,
            ethers.utils.parseEther("100")
        );
        await tx.wait();
    });

    it("Checking condition of addr1 account with 1 PumpkittenNFT", async function () {
        tx = await fantoonAI.connect(addr1).check(addr1.address);
        expect(tx).to.equal(1);
    });

    it("Checking condition of addr2 account without any token", async function () {
        tx = await fantoonAI.connect(addr2).check(addr2.address);
        expect(tx).to.equal(0);
    });

    it("Transfering 50 token to addr2", async function () {
        tx = await diamondToken.transfer(
            addr2.address,
            ethers.utils.parseEther("50")
        );
        await tx.wait();
    });

    it("Paying monthly about addr2 account", async function () {

        tx = await diamondToken.connect(addr2).approve(fantoonAI.address, approveAmount);
        await tx.wait();
        tx = await fantoonAI.connect(addr2).pay(1);
        await tx.wait();
        tx = await fantoonAI.connect(addr2).check(addr2.address);
    });

    it("Checking condition of addr2 account with 50 diamondToken", async function () {
        tx = await fantoonAI.connect(addr2).check(addr2.address);
        expect(tx).to.equal(5);
    });

});
