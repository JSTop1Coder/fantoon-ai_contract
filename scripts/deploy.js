const { ethers } = require("hardhat");
const { parseEther } = ethers.utils;
const { AddressZero } = ethers.constants;

const sleep = async (seconds) => {
  return new Promise(resolve => setTimeout(resolve, seconds * 1000))
}

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
  const [deployer] = await ethers.getSigners();

  // Setting token and NFTs addresss already deployed on mainnet
  const diamondTokenAddress = "0xdda0f0e1081b8d64ab1d64621eb2679f93086705";
  const pumpkittenAddress = "0xF185cf59c710a0E83362fb7B8813b633Ba073600";
  const samuraikittenAddress = "0x4a0FBe0Af74Cf38bcd5C68f1D6bf2Cc0899cc0FF";
  const bitkittenAddress = "0x896D8347652e190f3CdB909938A0e7447aBA8bB5"

  // Deploying
  const FantoonAI = await deploy("FantoonAI");

  // Setting requisites to the FantoonAI contract
  await (await FantoonAI.addRequisite("Pumpkitten & Diamond 250", pumpkittenAddress, 1, diamondTokenAddress, parseEther("250"))).wait();
  await (await FantoonAI.addRequisite("Samurai & Diamond 500", samuraikittenAddress, 1, diamondTokenAddress, parseEther("500"))).wait();
  await (await FantoonAI.addRequisite("Bitkitten & Diamond 500", bitkittenAddress, 1, diamondTokenAddress, parseEther("500"))).wait();
  await (await FantoonAI.addRequisite("Diamond 1000", AddressZero, 0, diamondTokenAddress, parseEther("1000"))).wait();

  // Setting threshold of diamondToken
  await (await FantoonAI.setToken(diamondTokenAddress, parseEther("50"))).wait()
}

main()
  .then(() => process.exit())
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });