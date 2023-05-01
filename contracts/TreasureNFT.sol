// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract TreasureNFT is ERC721Enumerable, Ownable {
    uint256 private constant RESOLUTION = 100000;
    uint256 private constant ERROR_RANGE = 100;

    struct Coordinate {
        uint256 lat;
        uint256 lng;
    }

    // Mapping tokenId and coordinate
    mapping(uint256 => Coordinate) private coordinates;

    // hints
    mapping(uint256 => string) private hints;

    constructor() ERC721("TreasureNFT", "TSN") {
        coordinates[0] = Coordinate({lat: 3751453, lng: 12710786});
        hints[0] = "jamsilcoffeebean";

        coordinates[1] = Coordinate({lat: 3752468, lng: 12696439});
        hints[1] = "hybe";

        coordinates[2] = Coordinate({lat: 3751036, lng: 12707889});
        hints[2] = "sportsStarbucks";

        coordinates[4] = Coordinate({lat: 3751533, lng: 12713324});
        hints[4] = "starbucksInOlympic";
    }

    function mintTreasure(Coordinate memory coordinate) external {
        console.log("coordinate", coordinate.lat, coordinate.lng);
        for (uint i = 0; i < 5; i++)
            if (
                (coordinates[i].lat + ERROR_RANGE >= coordinate.lat &&
                    coordinate.lat >= coordinates[i].lat - ERROR_RANGE) &&
                (coordinates[i].lng + ERROR_RANGE >= coordinate.lng &&
                    coordinate.lng >= coordinates[i].lng - ERROR_RANGE)
            ) {
                _safeMint(msg.sender, i);
            }
    }

    // contract owner can set token's coordinate
    function setCoordinateByTokenId(
        uint256 _tokenId,
        Coordinate memory coordinate
    ) external onlyOwner {
        coordinates[_tokenId] = coordinate;
    }

    function getCoordinateByTokenId(
        uint256 _tokenId
    ) external view returns (Coordinate memory) {
        Coordinate memory coordinate = coordinates[_tokenId];
        return coordinate;
    }

    // contract owner can set token's hint
    function setHintByTokenId(
        uint256 _tokenId,
        string memory _hint
    ) external onlyOwner {
        hints[_tokenId] = _hint;
    }

    function getHintByTokenId(
        uint256 _tokenId
    ) external view returns (string memory) {
        return hints[_tokenId];
    }

    function _baseURI() internal pure override returns (string memory) {
        return "http://dapp-treasure.s3-website.ap-northeast-2.amazonaws.com/";
    }
}
