# CustomOracle
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/SimpleOracle.sol)


## State Variables
### verifier

```solidity
address public verifier;
```


### jobManager

```solidity
IJobSpecification public jobManager;
```


### proofs

```solidity
mapping(bytes32 => bytes32) public proofs;
```


## Functions
### constructor


```solidity
constructor(address _verifier, address _jobManager);
```

### submitAndVerifySignature


```solidity
function submitAndVerifySignature(bytes32 jobId, bytes memory signature) external;
```

### verifySignature


```solidity
function verifySignature(bytes32 jobId, bytes memory signature) external returns (bool);
```

### _verifySignature


```solidity
function _verifySignature(bytes32 jobId, bytes memory signature) internal returns (bool);
```

### _extractRSV


```solidity
function _extractRSV(bytes memory signature) internal pure returns (uint8 v, bytes32 r, bytes32 s);
```

## Events
### ProofSubmitted

```solidity
event ProofSubmitted(bytes32 indexed jobId, bytes32 proof);
```

