// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "contracts/src/SimpleJobHelper.sol";

contract SimpleJobHelperTest is Test {
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
        bytes memory inputData = chunk0; // Construct valid input data based on the Chunk structure

        // Expected results
        bytes32 expectedHash = hex"0085141d49b1eb227e7d7ecafd66c36f6943dfaa854fcb083ef04a0c1b1ccde6";

        bytes memory outputData = simpleJobHelper.encodeJobData(_jobType, chunk0);

        // Check if the outputData hash matches the expected hash
        bytes32 outputHash;
        assembly {
            outputHash := mload(add(outputData, 0x20))
        }

        require(expectedHash == outputHash, "data not match");
    }
}
