// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
 * Minimal UUPS implementation example.
 * This is educational — production proxies should use audited libraries (OpenZeppelin).
 */

contract UUPSLogicV1 {
    // storage slot for owner (slot 0)
    address public owner;
    uint256 public counter;

    event Upgraded(address indexed newImpl);

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    function initialize() public {
        require(owner == address(0), "initialized");
        owner = msg.sender;
    }

    function increment() external {
        counter += 1;
    }

    function upgradeTo(address /*newImpl*/) external virtual onlyOwner {
        // in UUPS, the implementation itself performs the upgrade via delegatecall to the proxy's slot
        emit Upgraded(address(0));
    }
}
