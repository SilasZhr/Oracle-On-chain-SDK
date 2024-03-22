// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/// @title IJobHelpers Interface
/// @dev Interface for utility functions for encoding and decoding job data.
interface IJobHelper {
    /// @dev Encodes job parameters into a single bytes string.
    /// @param jobType The type of job.
    /// @param inputData The detailed input of the job.
    /// @return The encoded job data.
    function encodeJobData(
        uint256 jobType,
        bytes calldata inputData
    ) external returns (bytes memory);

    /// @dev Decodes the job data bytes string back into its original parameters.
    /// @param jobData The encoded job data.
    /// @return jobType The type of job.
    /// @return jobDetails The detailed description of the job.
    function decodeJobData(
        bytes calldata jobData
    ) external pure returns (uint256 jobType, string memory jobDetails);
}
