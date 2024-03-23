# IJobHelper
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/interfaces/IJobHelper.sol)

*Interface for utility functions for encoding and decoding job data.*


## Functions
### encodeJobData

*Encodes job parameters into a single bytes string.*


```solidity
function encodeJobData(uint256 jobType, bytes calldata inputData) external returns (bytes memory);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobType`|`uint256`|The type of job.|
|`inputData`|`bytes`|The detailed input of the job.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes`|The encoded job data.|


### decodeJobData

*Decodes the job data bytes string back into its original parameters.*


```solidity
function decodeJobData(bytes calldata jobData) external pure returns (uint256 jobType, string memory jobDetails);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobData`|`bytes`|The encoded job data.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`jobType`|`uint256`|The type of job.|
|`jobDetails`|`string`|The detailed description of the job.|


