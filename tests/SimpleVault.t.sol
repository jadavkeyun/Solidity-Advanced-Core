// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import "forge-std/Test.sol";
import "../contracts/Vault/SimpleVault.sol";
import "../contracts/token/StorageToken.sol";

contract SimpleVaultTest is Test {
    StorageToken token;
    SimpleVault vault;

    function setUp() public {
        token = new StorageToken(1_000_000 ether);
        vault = new SimpleVault(address(token));
    }

    function test_deposit_withdraw() public {
        token.transfer(address(1), 100 ether);
        vm.prank(address(1));
        token.approve(address(vault), 100 ether);
        vm.prank(address(1));
        vault.deposit(100 ether);
        vm.prank(address(1));
        vault.withdraw(100 ether);
        assertEq(token.balanceOf(address(1)), 100 ether);
    }
}
