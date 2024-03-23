# ISubscriptionManager
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/interfaces/ISubscriptionManager.sol)

*Interface for the SubscriptionManager contract*


## Functions
### setJobPrice

*Allows the owner to set the price for a given job type.*


```solidity
function setJobPrice(uint256 jobType, uint256 price) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobType`|`uint256`|The type of job.|
|`price`|`uint256`|The price in wei to set for the given job type.|


### requestJob

*Allows users to request a job of a certain type and pay the associated fee.*


```solidity
function requestJob(bytes calldata taskDescription, uint256 jobType, bytes memory inputData, uint256 expiration)
    external
    payable;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`taskDescription`|`bytes`|Data or description of the job being requested.|
|`jobType`|`uint256`|The type of job from the predefined enum of job types.|
|`inputData`|`bytes`|Additional input data required for the job.|
|`expiration`|`uint256`|The expiration time for the job request.|


### withdrawPayments

*Withdraws accumulated payments from job requests to the owner's address.*


```solidity
function withdrawPayments() external;
```

