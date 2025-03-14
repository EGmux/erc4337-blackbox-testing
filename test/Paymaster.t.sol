// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import {Test} from "forge-std/Test.sol";

contract PaymasterTest {
	
	EntryPoint entryPoint;

	function setUp() public{
		entryPoint = new EntryPoint();	
	}

    	// the zero address can't be the paymaster address
	function proveFail_depositToZeroAddress(address account, uint256 dealt, uint256 deposit ) public{
		
		require(account == address(0));
		require(deposit <= dealt);

		deal(account, dealt);

		entryPoint.depositTo{value: deposit}(account);

	}

	// prove overflow is dealt with properly in depositTo
	function proveFail_depositToOverflow(address account, uint256 dealt, uint256 deposit) public{

		// https://docs.soliditylang.org/en/latest/types.html#address
		require(account == address(type(uint160).max + 1));
		require(deposit <= dealt);

		deal(account, dealt);

		entryPoint.depositTo{value: deposit}(account);

	}
	
    // prove stake can't be zero wei
    function proveFail_stakeCantBeZero(address account, uint256 dealt, uint256 deposit, uint32 delay, uint112 staked) public {
    
      // https://docs.soliditylang.org/en/latest/types.html#address
      require(account != address(type(uint160).max + 1) && account != address(0));
      require(deposit <= dealt && staked == uint112(0));

      deal(account, dealt );

      entryPoint.despositTo{value: deposit}(account);

      entryPoint.addStake{value: staked}(delay);
    }

    // prove stake must be at maximum (dealt - deposit)
    function prove_stakeMaximumAmmount(address account, uint256 dealt, uint256 deposit, uint32 delay, uint112 staked)public{


      require(account != address(type(uint160).max + 1) && account != address(0));
      require(deposit < dealt && staked == (dealt - deposit));
      
      deal(account, dealt );

      entryPoint.depositTo{value: deposit}(account);

      try entryPoint.addStake{value: staked}(account) {} catch {assert(false);}

      assert(entryPoint.getDepositInfo(account).stake == staked);

    }

    // prove stake can overflow
    function prove_stakeCanOverflow(address account, uint256 dealt, uint256 deposit, uint32 delay, uint112 staked)  public {

      require(account != address(type(uint160).max + 1) && account != address(0));
      require(deposit < dealt && staked == type(uint112).max && staked <= (dealt - deposit));

      deal(account, dealt );

      entryPoint.depositTo{value: deposit}(account);

      try entryPoint.addStake{value: staked}(account) {} catch {assert(true);}

    }
}
