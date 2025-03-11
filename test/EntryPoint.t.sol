// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import "../src/interfaces/PackedUserOperation.sol";
import {Test} from "forge-std/Test.sol";
import "./utils/TestUserOperations.sol";
import "./utils/PartialUserOperation.sol";


contract EntrypointBoundary is Test{
	EntryPoint entryPoint;
	Utils ut;


	function setUp() public {
		
		 entryPoint = new EntryPoint();
		 ut = new Utils();

	}

	function proveFail_ZeroAddressSender(PartialUserOperation memory partialUserOp, address payable beneficiary) public {
	    require(partialUserOp.sender == address(0), "Invalid arguments!");
            
	    PackedUserOperation[] memory userOps = new PackedUserOperation[](1);

	    userOps[0] = ut.convertPartialUserOperationToPackedUserOperation(partialUserOp, userOps[0]);(partialUserOp,userOps[0]);
		
    	    entryPoint.handleOps(userOps, beneficiary);
  }
}
