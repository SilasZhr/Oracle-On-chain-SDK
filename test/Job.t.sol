// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {JobSpecification} from "../contracts/src/Job.sol"; // Adjust the path to where your contract is
import {IJobSpecification} from "../contracts/src/interfaces/IJob.sol";

contract JobSpecificationTest is Test {
    JobSpecification jobManager;
    address trustedOracle;

    function setUp() public {
        // Set up your testing environment
        jobManager = new JobSpecification(address(0x01));
        trustedOracle = address(0x1); // Sample trusted oracle address
        jobManager.setTrustedOracle(trustedOracle, true);
    }

    function testSetTrustedOracle() public {
        // Testing setTrustedOracle function
        assert(jobManager.trustedOracles(trustedOracle));
    }

    function testCreateJob() public {
        // Testing createJob function
        bytes32 jobId = keccak256("Job1");
        bytes memory taskDescription = "Description for Job1";
        uint256 jobType = 1;
        bytes memory inputData = "Input data for Job1";
        uint256 expiration = 1 days;

        vm.prank(address(0x123)); // Prank the msg.sender to be a specific address
        jobManager.createJob(jobId, taskDescription, jobType, inputData, expiration);

        // Retrieving the job details
        IJobSpecification.Job memory job = jobManager.getJob(jobId);
        assert(job.jobType == jobType);
    }

    function testCompleteJob() public {
        // Testing completeJob function
        bytes32 jobId = keccak256("Job1");
        bytes memory taskDescription = "Description for Job1";
        uint256 jobType = 1;
        bytes memory inputData = "Input data for Job1";
        uint256 expiration = 1 days;

        // Create a new job first
        vm.prank(address(0x123)); // Prank the msg.sender to be a specific address
        jobManager.createJob(jobId, taskDescription, jobType, inputData, expiration);

        // Complete the job
        vm.prank(trustedOracle); // Prank the msg.sender to be the trusted oracle
        jobManager.completeJob(jobId);

        // Retrieving the job details
        IJobSpecification.Job memory job = jobManager.getJob(jobId);
        assert(job.isCompleted);
    }
}
