// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IJobSpecification} from "./interfaces/IJob.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract JobSpecification is IJobSpecification, Ownable {
    mapping(bytes32 => Job) public jobs;
    mapping(uint256 => address) public jobHelpers; // job helpers for decoding and decoding data if needed
    mapping(address => bool) public trustedOracles;

    // Events to log updates
    event OracleUpdated(address oracle, bool isTrusted);
    event JobHelperUpdated(uint256 jobType, address helper);

    /// @dev Modifier to check if the caller is a trusted oracle
    modifier onlyTrustedOracle() {
        require(trustedOracles[msg.sender], "Caller is not a trusted oracle");
        _;
    }

    /// @dev Modifier to check if the caller is the job owner
    modifier onlyJobOwner(bytes32 jobId) {
        require(jobs[jobId].requester == msg.sender, "Not authorized");
        _;
    }

    /**
     * @dev Function to add or update a trusted oracle
     * @param oracle The address of the oracle
     * @param isTrusted Boolean indicating whether the oracle is trusted
     */
    function setTrustedOracle(address oracle, bool isTrusted) external onlyOwner {
        trustedOracles[oracle] = isTrusted;
        emit OracleUpdated(oracle, isTrusted);
    }

    /// @dev Function to set a job helper address for a specific job type
    /// @param jobType The job type identifier
    /// @param helper The address of the job helper contract
    function setJobHelper(uint256 jobType, address helper) external onlyOwner {
        jobHelpers[jobType] = helper;
        emit JobHelperUpdated(jobType, helper);
    }

    function createJob(
        bytes32 jobId,
        bytes calldata taskDescription,
        uint256 jobType,
        bytes memory inputData,
        uint256 expiration
    ) external {
        require(jobs[jobId].requester == address(0), "Job already exists");
        jobs[jobId] = Job({
            taskDescriptionHash: keccak256(taskDescription),
            jobType: jobType,
            deadline: block.timestamp + expiration,
            requester: msg.sender,
            isCompleted: false,
            inputData: inputData, //TODO: just store inputDataHash or submit by blobs to save gas
            outputData: ""
        });
        emit JobCreated(jobId, msg.sender, taskDescription);
    }

    function completeJob(bytes32 jobId) external onlyTrustedOracle {
        require(!jobs[jobId].isCompleted, "Job already completed");
        require(block.timestamp <= jobs[jobId].deadline, "Job deadline exceeded");
        // Perform computation and update outputData
        jobs[jobId].outputData = "Computed output data";
        jobs[jobId].isCompleted = true;
        emit JobCompleted(jobId, keccak256(abi.encode(jobs[jobId].outputData)));
    }

    function getJob(bytes32 jobId) external view override returns (Job memory job) {
        job = jobs[jobId];
    }
}
