const { ethers, waffle } = require("hardhat");
const { parseEther } = ethers.utils;
const { AddressZero } = ethers.constants;

const deploy = async (contractName, ...args) => {
  const factory = await ethers.getContractFactory(contractName);
  const contract = await factory.deploy(...args);
  await contract.deployed();
  console.log("Deployed", contractName, contract.address);
  await verify(contract, args);
  return contract;
}

const verify = async (contract, args, retry = 3) => {
  if (["hardhat", "localhost"].includes(network.name)) return
  console.log("********************************************************")
  for (let i = 0; i < retry; i++) {
    try {
      await hre.run("verify:verify", {
        address: contract.address,
        constructorArguments: args,
      })
      break
    } catch (ex) {
      console.log("\t* Failed verify", args.join(','), ex.message)
      await sleep(5)
    }
  }
  console.log("********************************************************")
}

async function main() {
    const [deployer, addr1, addr2] = await ethers.getSigners();

    const approveAmount = "0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff";

    var tx;

    console.log("\n Deploying PumpkittensNFT.")
    const PumpkittensNFT = await deploy("Pumpkittens");

    console.log("\n Deploying BitkittensNFT.")
    const BitkittensNFT = await deploy("Bitkittens", PumpkittensNFT.address);

    console.log("\n Deploying SamuraikittensNFT.")
    const SamuraikittensNFT = await deploy("Samuraikittens", PumpkittensNFT.address);

    console.log("\n Deploying DiamondToken.");
    const DiamondToken = await deploy("Diamond");

    console.log("\nFantoonAI deploying...");
    const FantoonAIContract = await deploy("FantoonAI");

    // Setting token to the fantoonAI contract
    console.log("\nSetting token to the fantoonAI contract...");
    tx = await FantoonAIContract.setToken(DiamondToken.address, ethers.utils.parseEther("50"));
    await tx.wait();

    // Set requisites to the fantoonAI contract
    console.log("\nSet requisites to the fantoonAI contract...");
    tx = await FantoonAIContract.addRequisite("Pumpkitten & Diamond 100", PumpkittensNFT.address, 1, DiamondToken.address, ethers.utils.parseEther("100"));
    await tx.wait();
    tx = await FantoonAIContract.addRequisite("Samurai & Diamond 500", SamuraikittensNFT.address, 1, DiamondToken.address, ethers.utils.parseEther("500"));
    await tx.wait();
    tx = await FantoonAIContract.addRequisite("Bitkitten & Diamond 500", BitkittensNFT.address, 1, DiamondToken.address, ethers.utils.parseEther("500"));
    await tx.wait();
    tx = await FantoonAIContract.addRequisite("Diamond 1000", ethers.constants.AddressZero, 0, DiamondToken.address, ethers.utils.parseEther("1000"));
    await tx.wait();
     

    // var tx = await pk.connect(deployer).setMintReservedTokenPeriod(0);
    // await tx.wait();
    // var tx = await bk.connect(deployer).setMintReservedTokenPeriod(0);
    // await tx.wait();
    // var tx = await sk.connect(deployer).setMintReservedTokenPeriod(0);
    // await tx.wait();

    // // Minting 1 pumpkittenNFT to addr1
    // console.log("\nMinting 1 pumpkittenNFT to addr1");
    // tx = await pk.buyPumpkittens({ value: ethers.utils.parseEther("150.0"), gasLimit: 500000});
    // await tx.wait();

    // // Minting 1 bikittenNFT to addr1
    // console.log("\nMinting 1 bikittenNFT to addr1");
    // tx = await bk.buyKittens({ value: ethers.utils.parseEther("1"), gasLimit: 500000 });
    // await tx.wait();

    // // Minting 1 samuraiNFT to addr1
    // console.log("\nMinting 1 samuraikittenNFT to addr1");
    // tx = await sk.buyKittens({ value: ethers.utils.parseEther("449"), gasLimit: 500000 });
    // await tx.wait();


}

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });