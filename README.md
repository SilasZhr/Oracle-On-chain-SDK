# Oracle-On-chain-SDK


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
### case1 : TEE-Based Layer2 with Offchain Proof Computation
you can find detail [here](./docs/cases.md)