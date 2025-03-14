// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";

contract PaymasterTest {
	
	EntryPoint entryPoint;

	function setUp() public{
		entryPoint = new EntryPoint();	
	}

    	// the zero address can't be the paymaster address
	function proveFail_depositToZeroAddress(address account, uint256 dealt, uint256 deposit ) public{
		
		require(account == address(0));
		require(deposit <= dealt);

		vm.deal(account, dealt wei);

		entryPoint.depositTo{value: deposit}(account);

	}

	// prove overflow is dealt with properly in depositTo
	function proveFail_depositToOverflow(address account, uint256 dealt, uint256 deposit) public{

		// https://docs.soliditylang.org/en/latest/types.html#address
		require(account == address(type(uint160).max + 1));
		require(deposit <= dealt);

		vm.deal(account, dealt wei);

		entryPoint.depositTo{value: deposit}(account);

	}

	


}
