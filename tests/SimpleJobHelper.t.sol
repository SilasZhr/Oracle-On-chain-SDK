// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "ds-test/test.sol";
import "../src/SimpleJobHelper.sol";


contract SimpleJobHelperTest is DSTest {
    CheatCodes cheats = CheatCodes(HEVM_ADDRESS);
    SimpleJobHelper simpleJobHelper;

    function setUp() public {
        simpleJobHelper = new SimpleJobHelper();
    }

    function testEncodeJobData() public {
        // Example values
        uint256 _jobType = 1;
        bytes memory chunk0;

    chunk0 = new bytes(1 + 60 + 3 * 5);
    assembly {
      mstore(add(chunk0, 0x20), shl(248, 1)) // numBlocks = 1
      mstore(add(chunk0, add(0x21, 56)), shl(240, 3)) // numTransactions = 3
      mstore(add(chunk0, add(0x21, 58)), shl(240, 0)) // numL1Messages = 0
    }
    for (uint256 i = 0; i < 3; i++) {
      assembly {
        mstore(add(chunk0, add(93, mul(i, 5))), shl(224, 1)) // tx = "0x00"
      }
    }
        bytes memory inputData = hex"00..."; // Construct valid input data based on the Chunk structure

        // Expected results
        bytes32 expectedHash = keccak256(abi.encodePacked(inputData));

        bytes memory outputData = simpleJobHelper.encodeJobData(_jobType, inputData);
        
        // Check if the outputData hash matches the expected hash
        bytes32 outputHash;
        assembly {
            outputHash := mload(add(outputData, 0x20))
        }
        assertEq(outputHash, expectedHash, "Hash does not match expected value");
    }

    function testDecodeJobData() public {
        // Example encoded job data
        bytes memory jobData = hex"0001..."; // Construct job data with job type and job details

        // Decode the job data
        (uint256 jobType, string memory jobDetails) = simpleJobHelper.decodeJobData(jobData);

        // Check if the job type and job details are correctly decoded
        assertEq(jobType, 1, "Job type does not match expected value");

        // ... Additional assertions to verify correctness of job details ...
    }

    function testValidateChunkLength() public {
        // Example chunk data
        bytes memory chunkData = hex"01..."; // Construct valid chunk data

        // Calculate the chunk length
        uint256 chunkLength = simpleJobHelper.validateChunkLength(uint256(bytes32(chunkData)), chunkData.length);

        // ... Assertions to check if the chunk length is valid ...
    }

    // ... Additional test cases as needed ...
}

