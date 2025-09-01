// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract MultiSig {
    address[] public owners;
    uint256 public required;
    struct Tx { address to; uint256 value; bytes data; bool executed; uint256 confirmations; }
    Tx[] public transactions;
    mapping(uint256 => mapping(address => bool)) public approved;

    constructor(address[] memory _owners, uint256 _required) {
        owners = _owners; required = _required;
    }

    function submit(address to, uint256 value, bytes calldata data) external returns (uint256 txId) {
        txId = transactions.length;
        transactions.push(Tx(to, value, data, false, 0));
    }

    function approve(uint256 txId) external {
        require(!approved[txId][msg.sender], "already");
        approved[txId][msg.sender] = true;
        transactions[txId].confirmations += 1;
        if (transactions[txId].confirmations >= required) {
            transactions[txId].executed = true;
            (bool ok,) = transactions[txId].to.call{value: transactions[txId].value}(transactions[txId].data);
            require(ok, "exec fail");
        }
    }
}
