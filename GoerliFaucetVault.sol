// SPDX-License-Identifier: unlicense
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@uniswap/v3-periphery/contracts/interfaces/INonfungiblePositionManager.sol";

contract NftVault is ERC721Holder, Ownable {
    INonfungiblePositionManager public positionManager;

    constructor(address _positionManager) {
        positionManager = INonfungiblePositionManager(_positionManager);
    }

    function deposit(uint256 tokenId) external {
        // Transfer the NFT to this contract
        positionManager.safeTransferFrom(msg.sender, address(this), tokenId);
    }

    function withdraw(uint256 tokenId) external onlyOwner {
        // Only the owner of this contract can withdraw NFTs
        positionManager.safeTransferFrom(address(this), owner(), tokenId);
    }
}
