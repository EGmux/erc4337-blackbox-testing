// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../../src/interfaces/PackedUserOperation.sol";
import "./PartialUserOperation.sol";
import {Vm} from "forge-std/Vm.sol";

contract Utils{

	constructor(){}



	function convertPartialUserOperationToPackedUserOperation(PartialUserOperation memory partialUserOp, PackedUserOperation memory packed) public pure returns (PackedUserOperation memory){

		    packed.sender = partialUserOp.sender;
		    packed.nonce = partialUserOp.nonce;
		    // packed.initCode = bytes(0);
		    // packed.callData = bytes(0);
		    packed.accountGasLimits = partialUserOp.accountGasLimits;
		    packed.preVerificationGas = partialUserOp.preVerificationGas;
		    packed.gasFees = partialUserOp.gasFees;
		    // packed.paymasterAndData = bytes(0);
		    // packed.signature = key;
		    return packed;
		}



	function convertPartialUserOperationsToPackedUserOperations(PartialUserOperation[] memory partialUserOp, PackedUserOperation[] memory packed) public pure returns (PackedUserOperation[] memory){

		uint numOfOps = packed.length;

		for (uint256 i = 0; i < numOfOps; ++i){
		    packed[i].sender = partialUserOp[i].sender;
		    packed[i].nonce = partialUserOp[i].nonce;
		    // packed[i].initCode = bytes(0);
		    // packed[i].callData = bytes(0);
		    packed[i].accountGasLimits = partialUserOp[i].accountGasLimits;
		    packed[i].preVerificationGas = partialUserOp[i].preVerificationGas;
		    packed[i].gasFees = partialUserOp[i].gasFees;
		    // packed[i].paymasterAndData = bytes(0);
		    // packed[i].signature = bytes(0);
		}

		    return packed;
	}

}
