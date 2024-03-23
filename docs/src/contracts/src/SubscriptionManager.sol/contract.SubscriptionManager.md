# SubscriptionManager
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/SubscriptionManager.sol)

**Inherits:**
Ownable

*This contract allows users to pay for jobs based on their type, utilizing an enum to categorize job types and associated costs.*


## State Variables
### jobManager

```solidity
IJobSpecification public jobManager;
```


### jobPrices

```solidity
mapping(uint256 => uint256) public jobPrices;
```


### jobPayments

```solidity
mapping(bytes32 => uint256) public jobPayments;
```


## Functions
### constructor

*Initializes the contract with the address of the JobContract and default job prices.*


```solidity
constructor(address jobContractAddress);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`jobContractAddress`|`address`|The address of the related JobContract.|


### setJobPrice

*Allows the owner to set the price for a given job type.*


```solidity
function setJobPrice(uint256 jobType, uint256 price) external onlyOwner;
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
|`inputData`|`bytes`||
|`expiration`|`uint256`||


### withdrawRefund

*Withdraws accumulated payments to job requester.*


```solidity
function withdrawRefund(bytes32 jobId) external;
```

### withdrawPayments

*Withdraws accumulated payments from job requests to the owner's address.*


```solidity
function withdrawPayments() external onlyOwner;
```

### receive

*Reverts any direct ETH transfers to the contract.*


```solidity
receive() external payable;
```

