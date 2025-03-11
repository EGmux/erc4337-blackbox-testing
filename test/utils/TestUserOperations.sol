// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../../src/interfaces/PackedUserOperation.sol";
import "./PartialUserOperation.sol";


contract Utils{

	constructor(){}



	function convertPartialUserOperationToUserOperation(PartialUserOperation memory partialUserOp, PackedUserOperation memory packed) public pure returns (PackedUserOperation memory){

		    packed.sender = partialUserOp.sender;
		    packed.nonce = partialUserOp.nonce;
		    packed.accountGasLimits = partialUserOp.accountGasLimits;
		    packed.preVerificationGas = partialUserOp.preVerificationGas;
		    packed.gasFees = partialUserOp.gasFees;
		    return packed;
		}
	}

