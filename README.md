# Oracle-On-chain-SDK

Oracle-On-chain-SDK is a suite of smart contracts to bridge on-chain activities with off-chain compute workloads, leveraging Ethereum and Solidity. This involves managing subscriptions, encoding and decoding data for compute tasks, and ensuring secure, efficient communication between the blockchain and external compute resources.

## Process Overview

The workflow is composed of several key steps:

### 1. Job Submission and Payment

- The L2 network packages crucial data — block data, transaction data, and the state root — into a single bytes payload.
- This data, along with the payment, is submitted through the `requestJob` function call.

### 2. Job Processing and Commitment

- The `JobManager` uses a helper, selected according to the `jobType`, to decode input data and generate a cryptographic commitment.
- A job event is emitted to trigger off-chain services to commence computation, including the generation output.

### 3. Off-chain Service Submission and Verification

- Off-chain services, acting as oracles, submit the computation result for on-chain verification.
- Upon successful verification, the result is recorded by the `JobManager`, and a job completion event is emitted.

## For Users
To fully test this projetc, you will need to foundry and yarn
First, clone the repository and run the fowllowing command
```sh
yarn
```
Next, run the foundry tests:
```sh
# build with foundry
forge build

# unit tests with foundry
forge test
```
Also, you can run integration test in Hardhat:
```sh
yarn test
```

## For Developers

## contracts
  - [❱ src](contracts/src/README.md)
    - [❱ interfaces](contracts/src/interfaces/README.md)
      - [IJobSpecification](contracts/src/interfaces/IJob.sol/contract.IJobSpecification.md)
      - [IJobHelper](contracts/src/interfaces/IJobHelper.sol/contract.IJobHelper.md)
      - [ISubscriptionManager](contracts/src/interfaces/ISubscriptionManager.sol/contract.ISubscriptionManager.md)
    - [Counter](contracts/src/Counter.sol/contract.Counter.md)
    - [JobSpecification](contracts/src/Job.sol/contract.JobSpecification.md)
    - [SimpleJobHelper](contracts/src/SimpleJobHelper.sol/contract.SimpleJobHelper.md)
    - [CustomOracle](contracts/src/SimpleOracle.sol/contract.CustomOracle.md)
    - [SubscriptionManager](contracts/src/SubscriptionManager.sol/contract.SubscriptionManager.md)

## Use case
#### TEE-Based Layer2 with Offchain Proof Computation
you can find detail [here](./docs/cases.md)