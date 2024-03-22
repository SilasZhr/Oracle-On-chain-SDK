// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../src/SimpleOracle.sol";
import {JobSpecification} from "../src/Job.sol"; // Adjust the path to where your contract is
import {IJobSpecification} from "../src/interfaces/IJob.sol";

contract CustomOracleTest is Test {
    CustomOracle public oracle;
    JobSpecification jobManager;
    address trustedOracle;
    bytes32 jobId; // Job ID for testing
    uint8 v;
    bytes32 r;
    bytes32 s;

    function setUp() public {
        uint256 verifierPk = 0xa11ce;
        address verifier = vm.addr(verifierPk);

        bytes32 dataHash = keccak256("Signed by 0xSilas");

        (v, r, s) = vm.sign(verifierPk, dataHash);
        jobManager = new JobSpecification(address(0x01));
        trustedOracle = address(0x1); // Sample trusted oracle address
        jobManager.setTrustedOracle(trustedOracle, true);
        jobId = keccak256("test");
        bytes memory taskDescription = "Description for Job1";
        uint256 jobType = 1;
        bytes memory inputData = "Signed by 0xSilas";
        uint256 expiration = 1 days;
        jobManager.createJob(jobId, taskDescription, jobType, inputData, expiration);

        oracle = new CustomOracle(verifier, address(jobManager));
    }

    function testVerifySignature_Success() public {
        // Submit correct signature
        bytes memory correctSignature = abi.encodePacked(r, s, v);
        bool isValid = oracle.verifySignature(jobId, correctSignature);

        // Assert that the signature is valid
        assert(isValid == true);
    }

    function testVerifySignature_Failure() public {
        bytes memory incorrectSignature = abi.encodePacked(r, v, s); // Incorrect signature for testing

        // Submit incorrect signature
        bool isValid = oracle.verifySignature(jobId, incorrectSignature);

        // Assert that the signature is invalid
        assert(isValid == false);
    }
}
