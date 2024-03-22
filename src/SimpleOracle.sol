// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IJobSpecification} from "./interfaces/IJob.sol";

contract CustomOracle {
    //just for tests
    address public verifier;

    IJobSpecification public jobManager;

    // Mapping to store proofs for each job ID
    mapping(bytes32 => bytes32) public proofs;

    // Event emitted when a proof is submitted
    event ProofSubmitted(bytes32 indexed jobId, bytes32 proof);

    constructor(address _verifier, address _jobManager) {
        verifier = _verifier;
        jobManager = IJobSpecification(_jobManager);
    }

    // Function to submit a proof for a specific job ID
    function submitAndVerifySignature(bytes32 jobId, bytes memory signature) external {
        assert(_verifySignature(jobId, signature));
        jobManager.completeJob(jobId);
    }

    // Function to verify a proof for a specific job ID
    function verifySignature(bytes32 jobId, bytes memory signature) external returns (bool) {
        return _verifySignature(jobId, signature);
    }

    // Function to verify a proof for a specific job ID
    function _verifySignature(bytes32 jobId, bytes memory signature) internal returns (bool) {
        (uint8 v, bytes32 r, bytes32 s) = _extractRSV(signature);
        bytes memory commitment = jobManager.getJobCommitment(jobId);
        address signer = ecrecover(keccak256(commitment), v, r, s);
        return signer == verifier;
    }

    function _extractRSV(bytes memory signature) internal pure returns (uint8 v, bytes32 r, bytes32 s) {
        require(signature.length == 65, "Invalid signature length");

        assembly {
            // First 32 bytes are the `r` value
            r := mload(add(signature, 32))

            // Next 32 bytes are the `s` value
            s := mload(add(signature, 64))

            // The last byte is the `v` value
            v := byte(0, mload(add(signature, 96)))
        }
    }
}
