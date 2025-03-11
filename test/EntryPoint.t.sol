// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import "../src/interfaces/PackedUserOperation.sol";
import {Test} from "forge-std/Test.sol";

struct partialUserOp {
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

contract EntrypointBoundary is Test{
	EntryPoint entryPoint;


	function setUp() public {
		
		 entryPoint = new EntryPoint();

	}

	function proveFail_CallDataZeroAddressSender(partialUserOp memory puop, address payable beneficiary) public {
	    require(puop.sender == address(0), "Invalid arguments!");
            
	    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
	    userOps[0].sender = puop.sender;
	    userOps[0].nonce = puop.nonce;
	    userOps[0].accountGasLimits = puop.accountGasLimits;
	    userOps[0].preVerificationGas = puop.preVerificationGas;
	    userOps[0].gasFees = puop.gasFees;
	    entryPoint.handleOps(userOps, beneficiary);
    
  }
}
