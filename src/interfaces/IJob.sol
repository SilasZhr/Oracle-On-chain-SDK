// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/**
 * @title IJobSpecification
 * @dev Interface for managing job specifications
 */
interface IJobSpecification {

    /**
     * @dev Struct to represent a job
     */
    struct Job {
        bytes32 taskDescriptionHash; // Description of the task to be performed off-chain
        uint256 jobType; //Job types
        uint256 deadline; // Deadline for completing the job
        address requester; // Address of the requester / initiating the job
        bool isCompleted; // Flag indicating whether the job is completed
        bytes inputData; // Input data required for the computation
        bytes outputData; // Output data of the computation
    }

    /**
     * @dev Event emitted when a new job is created
     * @param jobId The unique identifier of the created job
     * @param requester The address of the requester initiating the job
     * @param description Description of the task to be performed off-chain
     */
    event JobCreated(bytes32 jobId, address requester, bytes description);

    /**
     * @dev Event emitted when a job is completed
     * @param jobId The unique identifier of the completed job
     * @param resultHash The result hash of the completed job
     */
    event JobCompleted(bytes32 jobId, bytes32 resultHash);

    /**
     * @dev Function to create a new job
     * @param jobId The unique identifier of the job
     * @param taskDescription Description of the task to be performed off-chain
     * @param jobType Job types
     * @param inputData Input data required for the computation
     * @param expiration Expiration time for the job
     */
    function createJob(
        bytes32 jobId,
        bytes calldata taskDescription,
        uint256 jobType,
        bytes memory inputData,
        uint256 expiration
    ) external;

    /**
     * @dev Function to mark a job as completed
     * @param jobId The unique identifier of the completed job
     */
    function completeJob(bytes32 jobId) external;
}
