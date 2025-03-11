// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;

// required struct until https://github.com/ethereum/hevm/issues/533 is fixed
struct PartialUserOperation {
    address sender;
    uint256 nonce;
    // bytes initCode;
    // bytes callData;
    bytes32 accountGasLimits;
    uint256 preVerificationGas;
    bytes32 gasFees;
    // bytes paymasterAndData;
    // bytes signature;
}
