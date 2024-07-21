require("dotenv").config();

console.log(`Alchemy API Key: ${process.env.ALCHEMY_API_KEY}`);
console.log(`Private Key: ${process.env.PRIVATE_KEY}`);

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying contracts with the account:", deployer.address);

  const ProjectAllocation = await ethers.getContractFactory("ProjectAllocation");
  const projectAllocation = await ProjectAllocation.deploy(deployer.address, 2000); // Pass the deployer's address and the total allowance

  await projectAllocation.deployed();

  console.log("ProjectAllocation deployed to:", projectAllocation.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
