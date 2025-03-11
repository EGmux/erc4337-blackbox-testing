// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../../src/interfaces/PackedUserOperation.sol";
import "./PartialUserOperation.sol";


contract Utils{

	constructor(){}



	function convertPartialUserOperationToPackedUserOperation(PartialUserOperation memory partialUserOp, PackedUserOperation memory packed) public pure returns (PackedUserOperation memory){

		    packed.sender = partialUserOp.sender;
		    packed.nonce = partialUserOp.nonce;
		    packed.accountGasLimits = partialUserOp.accountGasLimits;
		    packed.preVerificationGas = partialUserOp.preVerificationGas;
		    packed.gasFees = partialUserOp.gasFees;
		    return packed;
		}



	function convertPartialUserOperationsToPackedUserOperations(PartialUserOperation[] memory partialUserOp, PackedUserOperation[] memory packed) public pure returns (PackedUserOperation[] memory){

		uint numOfOps = packed.length;

		for (uint256 i = 0; i < numOfOps; ++i){
		    packed[i].sender = partialUserOp[i].sender;
		    packed[i].nonce = partialUserOp[i].nonce;
		    packed[i].accountGasLimits = partialUserOp[i].accountGasLimits;
		    packed[i].preVerificationGas = partialUserOp[i].preVerificationGas;
		    packed[i].gasFees = partialUserOp[i].gasFees;
		}

		    return packed;
	}

}
