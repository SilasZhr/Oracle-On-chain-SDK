// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title ISubscriptionManager
 * @dev Interface for the SubscriptionManager contract
 */
interface ISubscriptionManager {
  /**
   * @dev Allows the owner to set the price for a given job type.
   * @param jobType The type of job.
   * @param price The price in wei to set for the given job type.
   */
  function setJobPrice(uint256 jobType, uint256 price) external;

  /**
   * @dev Allows users to request a job of a certain type and pay the associated fee.
   * @param taskDescription Data or description of the job being requested.
   * @param jobType The type of job from the predefined enum of job types.
   * @param inputData Additional input data required for the job.
   * @param expiration The expiration time for the job request.
   */
  function requestJob(
    bytes calldata taskDescription,
    uint256 jobType,
    bytes memory inputData,
    uint256 expiration
  ) external payable;

  /**
   * @dev Withdraws accumulated payments from job requests to the owner's address.
   */
  function withdrawPayments() external;
}
