// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.23;
import "../src/core/EntryPoint.sol";
import "../src/interfaces/PackedUserOperation.sol";
import {Test} from "forge-std/Test.sol";
import {Vm} from "forge-std/Vm.sol";
import "./utils/TestUserOperations.sol";
import "./utils/PartialUserOperation.sol";
import "./utils/Tools.sol";
import {SimpleAccountFactory} from "./utils/SimpleAccountFactory.sol";

contract EntrypointBoundary is Test {
    EntryPoint entryPoint;
    testUtils ut;
    SimpleAccountFactory public factory;

    function setUp() public {
        entryPoint = new EntryPoint();
        ut = new testUtils();
        factory = SimpleAccountFactory(
            0xDD0f9cB4Cf53d28b976C13e7ee4a169F841924c0
        );
    }

    // Proves that nonce is zero, PackedUserOperation is valid and beneficiary not zero address 
    function check_ZeroNonceNeverRevertsIfPackedUserOperationIsValid(
        PartialUserOperation memory partialUserOp,
        address payable beneficiary
    ) public {
	       vm.assume(partialUserOp.nonce == 0 && beneficiary != address(0) && partialUserOp.sender != address(0));

	       PackedUserOperation[] memory userOps = new PackedUserOperation[](1);
		// bytes32 expectedUserOpHash = hex"e97f70cada097ce881426a3f199e4f95895765659985161e1930def8e1f7b04f";

		uint8 version = 1;
		uint48 validUntil = 0;


		  bytes32[2] memory publicKey = [
			    bytes32(
				0xe7f630b0eb3594e991cfadbd4047cd5fecddf379b4a4458e3ea2b9566e09882a
			    ),
			    bytes32(
				0x3e9775709101f2b294ddec0536f0f260570b6f009bff2096995d3e1d986239dd
			    )
			];

		  SimpleAccount account = factory.createAccount(publicKey);
		vm.deal(address(account), 1 ether);


		// bytes memory challengeToSign = abi.encodePacked(
		//     version,
		//     validUntil,
		//     expectedUserOpHash
		// );

		//       bytes memory ownerSig = abi.encodePacked(
		//     version,
		//     validUntil,
		//     abi.encode( // signature
		// 	Utils.rawSignatureToSignature({
		// 	    challenge: challengeToSign,
		// 	    r: 0xafb3561771f09d5119b12350f9089874e21a193a37b40c3f872ff4a93730f727,
		// 	    s: 0x9f2756dc68bd36de31ed67b3f775bf604e86547867796e9679d4b4673aef81e9
		// 	})
		//     )
		// );

	       userOps[0] = ut.convertPartialUserOperationToPackedUserOperation(
	           partialUserOp,
	           userOps[0]
	       );

	       userOps[0].sender = address(account);
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
