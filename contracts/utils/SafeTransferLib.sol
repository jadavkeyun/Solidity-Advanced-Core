// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/*
 Minimal SafeTransferLib: safe ETH and ERC20 transfers using low-level calls.
*/
library SafeTransferLib {
    function safeTransferETH(address to, uint256 amount) internal returns (bool) {
        (bool ok,) = to.call{value: amount}("");
        return ok;
    }

    function safeTransfer(address token, address to, uint256 amount) internal returns (bool) {
        (bool ok, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, amount));
        if (!ok) return false;
        if (data.length == 0) return true; // non-standard ERC20
        return abi.decode(data, (bool));
    }
}
