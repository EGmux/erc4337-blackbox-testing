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

	
    // /// @inheritdoc IStakeManager
    // function addStake(uint32 unstakeDelaySec) external payable {
    //     DepositInfo storage info = deposits[msg.sender];
    //     require(unstakeDelaySec > 0, "must specify unstake delay");
    //     require(
    //         unstakeDelaySec >= info.unstakeDelaySec,
    //         "cannot decrease unstake time"
    //     );
    //     uint256 stake = info.stake + msg.value;
    //     require(stake > 0, "no stake specified");
    //     require(stake <= type(uint112).max, "stake overflow");
    //     deposits[msg.sender] = DepositInfo(
    //         info.deposit,
    //         true,
    //         uint112(stake),
    //         unstakeDelaySec,
    //         0
    //     );
    //     emit StakeLocked(msg.sender, stake, unstakeDelaySec);
    // }
    //

    // prove stake can't be zero wei
    function proveFail_stakeCantBeZero(address account, uint256 dealt, uint256 deposit, uint32 delay, uint112 staked) public {
		
		// https://docs.soliditylang.org/en/latest/types.html#address
		require(account != address(type(uint160).max + 1) && account != address(0));
		require(deposit <= dealt && staked == uint112(0));

		vm.deal(account, dealt wei);

		entryPoint.despositTo{value: deposit}(account);

		entryPoint.addStake{value: staked}(delay);
    }
}
