# JobSpecification
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/Job.sol)

**Inherits:**
[IJobSpecification](/contracts/src/interfaces/IJob.sol/contract.IJobSpecification.md), Ownable


## State Variables
### jobs

```solidity
mapping(bytes32 => Job) public jobs;
```


### jobHelpers

```solidity
mapping(uint256 => address) public jobHelpers;
```


### trustedOracles

```solidity
mapping(address => bool) public trustedOracles;
```


## Functions
### onlyTrustedOracle

*Modifier to check if the caller is a trusted oracle*


```solidity
modifier onlyTrustedOracle();
```

### onlyJobOwner

*Modifier to check if the caller is the job owner*


```solidity
modifier onlyJobOwner(bytes32 jobId);
```

### constructor


```solidity
constructor(address jobHelperAddress);
```

### setTrustedOracle

*Function to add or update a trusted oracle*


```solidity
function setTrustedOracle(address oracle, bool isTrusted) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`oracle`|`address`|The address of the oracle|
|`isTrusted`|`bool`|Boolean indicating whether the oracle is trusted|


### setJobHelper

*Function to set a job helper address for a specific job type*


```solidity
function setJobHelper(uint256 jobType, address helper) external onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobType`|`uint256`|The job type identifier|
|`helper`|`address`|The address of the job helper contract|


### createJob


```solidity
function createJob(
    bytes32 jobId,
    bytes calldata taskDescription,
    uint256 jobType,
    bytes memory inputData,
    uint256 expiration
) external;
```

### completeJob


```solidity
function completeJob(bytes32 jobId) external onlyTrustedOracle;
```

### getJob


```solidity
function getJob(bytes32 jobId) external view returns (Job memory job);
```

### getJobCommitment


```solidity
function getJobCommitment(bytes32 jobId) external returns (bytes memory commitment);
```

### isRefundable


```solidity
function isRefundable(bytes32 jobId, address requester) external view returns (bool);
```

### _setJobHelper

*Function to set a job helper address for a specific job type*


```solidity
function _setJobHelper(uint256 jobType, address helper) internal onlyOwner;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobType`|`uint256`|The job type identifier|
|`helper`|`address`|The address of the job helper contract|


## Events
### OracleUpdated

```solidity
event OracleUpdated(address oracle, bool isTrusted);
```

### JobHelperUpdated

```solidity
event JobHelperUpdated(uint256 jobType, address helper);
```

