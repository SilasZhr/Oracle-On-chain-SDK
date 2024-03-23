# IJobSpecification
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/interfaces/IJob.sol)

*Interface for managing job specifications*


## Functions
### createJob

*Function to create a new job*


```solidity
function createJob(
    bytes32 jobId,
    bytes calldata taskDescription,
    uint256 jobType,
    bytes memory inputData,
    uint256 expiration
) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobId`|`bytes32`|The unique identifier of the job|
|`taskDescription`|`bytes`|Description of the task to be performed off-chain|
|`jobType`|`uint256`|Job types|
|`inputData`|`bytes`|Input data required for the computation|
|`expiration`|`uint256`|Expiration time for the job|


### completeJob

*Function to mark a job as completed*


```solidity
function completeJob(bytes32 jobId) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobId`|`bytes32`|The unique identifier of the completed job|


### getJob

*Retrieves the details of a job using its unique identifier.*


```solidity
function getJob(bytes32 jobId) external view returns (Job memory job);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobId`|`bytes32`|The unique identifier of the job to be retrieved.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`job`|`Job`|The Job struct containing the details of the specified job.|


### getJobCommitment

*Retrieves the details of a job using its unique identifier.*


```solidity
function getJobCommitment(bytes32 jobId) external returns (bytes memory commitment);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobId`|`bytes32`|The unique identifier of the job to be retrieved.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`commitment`|`bytes`|The commitment containing the commits to the specified job.|


### isRefundable

*Retrieves if a job should refund to requester.*


```solidity
function isRefundable(bytes32 jobId, address requester) external view returns (bool);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobId`|`bytes32`|The unique identifier of the job to be retrieved.|
|`requester`|`address`||


## Events
### JobCreated
*Event emitted when a new job is created*


```solidity
event JobCreated(bytes32 jobId, address requester, bytes description);
```

### JobCompleted
*Event emitted when a job is completed*


```solidity
event JobCompleted(bytes32 jobId, bytes32 resultHash);
```

## Structs
### Job
*Struct to represent a job*


```solidity
struct Job {
    bytes32 taskDescriptionHash;
    uint256 jobType;
    uint256 deadline;
    address requester;
    bool isCompleted;
    bytes inputData;
    bytes outputData;
}
```

