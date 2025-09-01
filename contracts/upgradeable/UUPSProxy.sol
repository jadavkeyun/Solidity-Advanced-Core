// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
 Educational minimal UUPS-style proxy.
 Stores implementation at EIP-1967 slot and delegates calls.
*/
contract UUPSProxy {
    // EIP-1967 implementation slot: bytes32(uint256(keccak256('eip1967.proxy.implementation')) - 1)
    bytes32 private constant IMPLEMENTATION_SLOT = 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc;

    constructor(address impl, bytes memory data) payable {
        assembly {
            sstore(IMPLEMENTATION_SLOT, impl)
        }
        if (data.length > 0) {
            (bool ok, ) = impl.delegatecall(data);
            require(ok, "init fail");
        }
    }

    fallback() external payable {
        assembly {
            let impl := sload(IMPLEMENTATION_SLOT)
            calldatacopy(0, 0, calldatasize())
            let res := delegatecall(gas(), impl, 0, calldatasize(), 0, 0)
            returndatacopy(0, 0, returndatasize())
            switch res
            case 0 { revert(0, returndatasize()) }
            default { return(0, returndatasize()) }
        }
    }

    receive() external payable {}
}
