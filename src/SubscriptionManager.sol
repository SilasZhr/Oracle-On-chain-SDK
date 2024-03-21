// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IJobSpecification} from "./interfaces/IJob.sol";

/// @title Pay-Per-Job Subscription Contract
/// @dev This contract allows users to pay for jobs based on their type, utilizing an enum to categorize job types and associated costs.
contract SubscriptionManager is Ownable {
    IJobSpecification public jobManager;

    // Mapping from job type to its price in wei
    mapping(uint256 => uint256) public jobPrices;

    /// @dev Initializes the contract with the address of the JobContract and default job prices.
    /// @param jobContractAddress The address of the related JobContract.
    constructor(address jobContractAddress) {
        jobManager = IJobSpecification(jobContractAddress);
        // Set default prices for each job type
        jobPrices[0] = 0.01 ether;
        jobPrices[1] = 0.02 ether;
        jobPrices[2] = 0.03 ether;
    }

    /// @dev Allows the owner to set the price for a given job type.
    /// @param jobType The type of job.
    /// @param price The price in wei to set for the given job type.
    function setJobPrice(uint256 jobType, uint256 price) external onlyOwner {
        jobPrices[jobType] = price;
    }

    /// @dev Allows users to request a job of a certain type and pay the associated fee.
    /// @param taskDescription Data or description of the job being requested.
    /// @param jobType The type of job from the predefined enum of job types.
    function requestJob(bytes calldata taskDescription, uint256 jobType, bytes memory inputData, uint256 expiration)
        external
        payable
    {
        uint256 price = jobPrices[jobType];
        require(price > 0, "Job type not recognized");
        require(msg.value == price, "Incorrect payment amount");

        //Assume we just allow user initiate off-chain compute tasks once per block
        bytes32 jobId = keccak256(abi.encode(msg.sender, jobType, block.number));

        jobManager.createJob(jobId, taskDescription, jobType, inputData, expiration);
    }

    /// @dev Withdraws accumulated payments from job requests to the owner's address.
    function withdrawPayments() external onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw.");
        (bool success,) = owner().call{value: balance}("");
        require(success, "Transfer failed.");
    }

    /// @dev Reverts any direct ETH transfers to the contract.
    receive() external payable {
        revert("Direct payment not accepted, use requestJob function.");
    }
}
