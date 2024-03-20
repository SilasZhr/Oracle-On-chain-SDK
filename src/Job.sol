// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IJobSpecification} from "./interfaces/IJob.sol";

contract JobSpecification is IJobSpecification{

    mapping(bytes32 => Job) public jobs;

    function createJob(
        bytes32 jobId,
        bytes calldata taskDescription,
        bytes memory inputData,
        uint256 expiration
    ) external {
        require(jobs[jobId].requester == address(0), "Job already exists");
        jobs[jobId] = Job({
            taskDescriptionHash: keccak256(taskDescription),
            deadline: block.timestamp + expiration,
            requester: msg.sender,
            isCompleted: false,
            inputData: inputData, //TODO: save inputData as calldata or in submit by blob
            outputData: ""
        });
        emit JobCreated(jobId, msg.sender, taskDescription);
    }

    function completeJob(bytes32 jobId) external {
        require(jobs[jobId].requester == msg.sender, "Not authorized to complete this job");
        require(!jobs[jobId].isCompleted, "Job already completed");
        require(block.timestamp <= jobs[jobId].deadline, "Job deadline exceeded");
        // Perform computation and update outputData
        jobs[jobId].outputData = "Computed output data";
        jobs[jobId].isCompleted = true;
        emit JobCompleted(jobId, keccak256(abi.encode(jobs[jobId].outputData)));
    }
}
