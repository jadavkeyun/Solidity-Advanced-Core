// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;
import "forge-std/Test.sol";
import "../contracts/upgradeable/UUPSImplementation.sol";
import "../contracts/upgradeable/UUPSProxy.sol";

contract ProxyTest is Test {
    function test_proxy_calls() public {
        // Deploy impl and proxy, then call initialize via constructor delegatecall data
        bytes memory initData = abi.encodeWithSignature("initialize()");
        UUPSImplementation impl = new UUPSImplementation();
        UUPSProxy proxy = new UUPSProxy(address(impl), initData);
        // interact via low-level call to increment
        (bool ok,) = address(proxy).call(abi.encodeWithSignature("increment()"));
        assertTrue(ok);
    }
}
