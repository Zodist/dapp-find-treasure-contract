const path = require("path");

import { ethers, artifacts } from "hardhat";

async function main() {
  const TreasureNFT = await ethers.getContractFactory("TreasureNFT");
  const treasureNFT = await TreasureNFT.deploy();

  await treasureNFT.deployed();

  saveFrontendFiles(treasureNFT, "treasure", "TreasureNFT");

  console.log(`Treasure Token address: ${treasureNFT.address}`);
}

function saveFrontendFiles(token: any, name: string, artifactsName: string) {
  const fs = require("fs");
  const frontProjectName = "dapp-find-treasure-front-cra";
  const contractsDir = path.join(
    __dirname,
    "../..",
    frontProjectName,
    "src",
    "contracts"
  );

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    path.join(contractsDir, `${name}-contract-address.json`),
    JSON.stringify({ Token: token.address }, undefined, 2)
  );

  const TokenArtifact = artifacts.readArtifactSync(artifactsName);

  fs.writeFileSync(
    path.join(contractsDir, `${name}-token.json`),
    JSON.stringify(TokenArtifact, null, 2)
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
