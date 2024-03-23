# SimpleJobHelper
[Git Source](https://github.com/SilasZhr/Oracle-On-chain-SDK/blob/8dfc03f46f3585453ffab61dafc24de4dfde7f13/contracts/src/SimpleJobHelper.sol)

**Inherits:**
[IJobHelper](/contracts/src/interfaces/IJobHelper.sol/contract.IJobHelper.md)

*Below is the encoding for `Chunk`, total 60*n+1+m bytes.
```text
* Field           Bytes       Type            Index       Comments
* numBlocks       1           uint8           0           The number of blocks in this chunk
* block[0]        60          BlockContext    1           The first block in this chunk
* ......
* block[i]        60          BlockContext    60*i+1      The (i+1)'th block in this chunk
* ......
* block[n-1]      60          BlockContext    60*n-59     The last block in this chunk
* l2Transactions  dynamic     bytes           60*n+1
```*

*Below is the encoding for `BlockContext`, total 60 bytes.
```text
* Field                   Bytes      Type         Index  Comments
* blockNumber             8          uint64       0      The height of this block.
* timestamp               8          uint64       8      The timestamp of this block.
* baseFee                 32         uint256      16     The base fee of this block. Currently, it is always 0, because we disable EIP-1559.
* gasLimit                8          uint64       48     The gas limit of this block.
* numTransactions         2          uint16       56     The number of transactions in this block, both L1 & L2 txs.
* numL1Messages           2          uint16       58     The number of l1 messages in this block.
```*

*Implements the IJobHelper interface for basic encoding and decoding of job data.*


## State Variables
### BLOCK_CONTEXT_LENGTH

```solidity
uint256 internal constant BLOCK_CONTEXT_LENGTH = 60;
```


### jobType

```solidity
uint256 internal constant jobType = 1;
```


## Functions
### encodeJobData

*Encodes job parameters into a single bytes string.,
decode input chunk data and generate a cryptographic commitment.*


```solidity
function encodeJobData(uint256 _jobType, bytes calldata inputData)
    external
    override
    returns (bytes memory outputData);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_jobType`|`uint256`||
|`inputData`|`bytes`|The detailed input of the job.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`outputData`|`bytes`|The encoded job data.|


### decodeJobData

*Decodes the job data bytes string back into its original parameters.*


```solidity
function decodeJobData(bytes calldata jobData)
    external
    pure
    override
    returns (uint256 jobType, string memory jobDetails);
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


### validateChunkLength

Validate the length of chunk.


```solidity
function validateChunkLength(uint256 chunkPtr, uint256 _length) internal pure returns (uint256 _numBlocks);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chunkPtr`|`uint256`|The start memory offset of the chunk in memory.|
|`_length`|`uint256`|The length of the chunk.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_numBlocks`|`uint256`|The number of blocks in current chunk.|


### l2TxPtr

Return the start memory offset of `l2Transactions`.

*The caller should make sure `_numBlocks` is correct.*


```solidity
function l2TxPtr(uint256 chunkPtr, uint256 _numBlocks) internal pure returns (uint256 _l2TxPtr);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chunkPtr`|`uint256`|The start memory offset of the chunk in memory.|
|`_numBlocks`|`uint256`|The number of blocks in current chunk.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_l2TxPtr`|`uint256`|the start memory offset of `l2Transactions`.|


### numBlocks

Return the number of blocks in current chunk.


```solidity
function numBlocks(uint256 chunkPtr) internal pure returns (uint256 _numBlocks);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chunkPtr`|`uint256`|The start memory offset of the chunk in memory.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_numBlocks`|`uint256`|The number of blocks in current chunk.|


### copyBlockContext

Copy the block context to another memory.


```solidity
function copyBlockContext(uint256 chunkPtr, uint256 dstPtr, uint256 index) internal pure returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`chunkPtr`|`uint256`|The start memory offset of the chunk in memory.|
|`dstPtr`|`uint256`|The destination memory offset to store the block context.|
|`index`|`uint256`|The index of block context to copy.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|uint256 The new destination memory offset after copy.|


### numTransactions

Return the number of transactions in current block.


```solidity
function numTransactions(uint256 blockPtr) internal pure returns (uint256 _numTransactions);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`blockPtr`|`uint256`|The start memory offset of the block context in memory.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_numTransactions`|`uint256`|The number of transactions in current block.|


### numL1Messages

Return the number of L1 messages in current block.


```solidity
function numL1Messages(uint256 blockPtr) internal pure returns (uint256 _numL1Messages);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`blockPtr`|`uint256`|The start memory offset of the block context in memory.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`_numL1Messages`|`uint256`|The number of L1 messages in current block.|


### loadL2TxHash

Compute and load the transaction hash.


```solidity
function loadL2TxHash(uint256 _l2TxPtr) internal pure returns (bytes32, uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`_l2TxPtr`|`uint256`|The start memory offset of the transaction in memory.|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`bytes32`|bytes32 The transaction hash of the transaction.|
|`<none>`|`uint256`|uint256 The start memory offset of the next transaction in memory.|


