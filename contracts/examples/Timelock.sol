// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Timelock {
    mapping(bytes32 => uint256) public timestamps;
    uint256 public delay = 2 days;
    address public admin;

    event Queue(bytes32 indexed txHash, uint256 executeAt);
    event Execute(bytes32 indexed txHash);

    constructor(address _admin) { admin = _admin; }

    function queue(address target, uint256 value, bytes calldata data) external returns (bytes32) {
        require(msg.sender == admin, "only admin");
        bytes32 txHash = keccak256(abi.encode(target, value, data));
        timestamps[txHash] = block.timestamp + delay;
        emit Queue(txHash, timestamps[txHash]);
        return txHash;
    }

    function execute(address target, uint256 value, bytes calldata data) external payable {
        bytes32 txHash = keccak256(abi.encode(target, value, data));
        require(timestamps[txHash] != 0 && block.timestamp >= timestamps[txHash], "not ready");
        delete timestamps[txHash];
        (bool ok, ) = target.call{value: value}(data);
        require(ok, "call failed");
        emit Execute(txHash);
    }
}
