import { expect } from "chai";
import { ethers } from "hardhat";
import { Signer } from "ethers";

describe("TreasureNFT", function () {
  let owner: Signer;
  before(async () => {
    [owner] = await ethers.getSigners();
  });

  it("Should have 10 nfts", async () => {
    const TreasureNFT = await ethers.getContractFactory("TreasureNFT");
    const treasureNFT = await TreasureNFT.deploy();

    await treasureNFT.deployed();
    console.log("Treasure", )

    expect(await treasureNFT.balanceOf(await owner.getAddress())).to.be.equal(0)

    const posi = { lat: 3751036, long: 12707889 };
    await treasureNFT.mintTreasure(posi)

    expect(await treasureNFT.balanceOf(await owner.getAddress())).to.be.equal(1)
  });
});
