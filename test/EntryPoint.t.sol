// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import "../src/interfaces/PackedUserOperation.sol";
import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import "./utils/TestUserOperations.sol";
import "./utils/PartialUserOperation.sol";

contract EntrypointBoundary is Test {
    EntryPoint entryPoint;
    Utils ut;

    function setUp() public {
        entryPoint = new EntryPoint();
        ut = new Utils();

    }

        // Proves that nonce is zero, PackedUserOperation is valid and beneficiary not zero address 
    function check_ZeroNonceNeverRevertsIfPackedUserOperationIsValid(
        PartialUserOperation memory partialUserOp,
        address payable beneficiary
    ) public {
	uint256 key;
	// (partialUserOp.sender, key) = makeAddrAndKey("bob");
	       vm.assume(partialUserOp.nonce == 0 && beneficiary != address(0) && partialUserOp.sender != address(0));

	       PackedUserOperation[] memory userOps = new PackedUserOperation[](1);

	       bytes memory ownerSig = abi.encodePacked(
            version,
            validUntil,
            abi.encode( // signature
                Utils.rawSignatureToSignature({
                    challenge: challengeToSign,
                    r: 0xafb3561771f09d5119b12350f9089874e21a193a37b40c3f872ff4a93730f727,
                    s: 0x9f2756dc68bd36de31ed67b3f775bf604e86547867796e9679d4b4673aef81e9
                })
            )
        );
	       userOps[0] = ut.convertPartialUserOperationToPackedUserOperation(
	           partialUserOp,
	           userOps[0]
	       );
	       userOps[0].initCode = hex"";
	       userOps[0].callData = hex"00";
	       userOps[0].paymasterAndData = hex"";
	       userOps[0].signature = hex"00";

	       entryPoint.handleOps(userOps, beneficiary);
    }


    // Proves that Entrypoint reverts if sender address overflows.
    function proveFail_SenderAddressOverflow(
        PartialUserOperation memory partialUserOp,
        address payable beneficiary
    ) public {
        require(
            partialUserOp.sender == address(type(uint160).max + 1)
        );

        PackedUserOperation[] memory userOps = new PackedUserOperation[](1);

        userOps[0] = ut.convertPartialUserOperationToPackedUserOperation(
            partialUserOp,
            userOps[0]
        );
        (partialUserOp, userOps[0]);

        entryPoint.handleOps(userOps, beneficiary);
    }

    // Proves that Entrypoint reverts if sender address is zero
    function proveFail_ZeroAddressSender(
        PartialUserOperation memory partialUserOp,
        address payable beneficiary
    ) public {
        require(partialUserOp.sender == address(0));

        PackedUserOperation[] memory userOps = new PackedUserOperation[](1);

        userOps[0] = ut.convertPartialUserOperationToPackedUserOperation(
            partialUserOp,
            userOps[0]
        );
        (partialUserOp, userOps[0]);

        entryPoint.handleOps(userOps, beneficiary);
    }



}
