## Use Case Documentation

This directory contains documentation for use cases.

## case1 : TEE-Based Layer2 with Offchain Computation

Imagine a sophisticated **Layer 2 blockchain network** utilizing **Trusted Execution Environments** for both enhanced security and off-chain computation. Rather than operating an SGX prover ourselves, we turn to the **Clique TEE services**.

Initially, the L2 network consolidates vital information into a bytes payload, which is then submitted through a unique `requestJob` function, accompanied by a fee for the computational services of the TEE.

Upon submission, our **JobManager** steps in. It identifies a helper according to the job's type to decode the input data and create a commitment, securing the integrity of the off-chain computation's base data.

A job event is then broadcasted, prompting the off-chain services, backed by the TEE's integrity and confidentiality, to initiate the necessary computations. For simplicity, the TEE signs the commitment with its internal private key, serving as the operation's cryptographic proof.

The final phase involves the off-chain service's critical role as the bridge to the blockchain. These services, in the capacity of oracles, submit the TEE's signed result for verification. Verification success hinges on the match between the submitted data and the initial cryptographic commitment.

Once verified, the result is relayed back to the **JobManager**. The workflow completes with the issuance of a job success event, assuring the network that the off-chain computation was accurately executed and validated on-chain, reinforcing the L2 network's operations' integrity and trustworthiness.


## Process Overview

The workflow is composed of several key steps:

### 1. Job Submission and Payment

- The L2 network packages crucial data — block data, transaction data, and the state root — into a single bytes payload.
- This data, along with the payment, is submitted through the `requestJob` function call.

### 2. Job Processing and Commitment

- The `JobManager` uses a helper, selected according to the `jobType`, to decode input data and generate a cryptographic commitment.
- A job event is emitted to trigger off-chain services to commence computation, including the generation of a TEE report (simplified to a TEE-signed commitment).

### 3. Off-chain Service Submission and Verification

- Off-chain services, acting as oracles, submit the TEE-signed result for on-chain verification.
- Upon successful verification, the result is recorded by the `JobManager`, and a job completion event is emitted.


