// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "../token/StorageToken.sol";

/*
 Minimal ERC4626-like vault for demonstration.
 Not a full ERC4626 implementation but shows deposit/withdraw accounting & shares.
*/
contract SimpleERC4626Like {
    StorageToken public asset;
    uint256 public totalShares;
    mapping(address => uint256) public sharesOf;

    event Deposit(address indexed caller, address indexed owner, uint256 assets, uint256 shares);
    event Withdraw(address indexed caller, address indexed receiver, uint256 assets, uint256 shares);

    constructor(address assetAddress) {
        asset = StorageToken(assetAddress);
    }

    function convertToShares(uint256 assets) public view returns (uint256) {
        if (totalShares == 0 || asset.balanceOf(address(this)) == 0) {
            return assets;
        }
        return (assets * totalShares) / asset.balanceOf(address(this));
    }

    function deposit(uint256 assets) external {
        uint256 shares = convertToShares(assets);
        require(shares > 0, "zero shares");
        asset.transferFrom(msg.sender, address(this), assets);
        sharesOf[msg.sender] += shares;
        totalShares += shares;
        emit Deposit(msg.sender, msg.sender, assets, shares);
    }

    function withdraw(uint256 shares) external {
        require(sharesOf[msg.sender] >= shares, "not enough shares");
        uint256 assets = (shares * asset.balanceOf(address(this))) / totalShares;
        sharesOf[msg.sender] -= shares;
        totalShares -= shares;
        asset.transfer(msg.sender, assets);
        emit Withdraw(msg.sender, msg.sender, assets, shares);
    }
}
