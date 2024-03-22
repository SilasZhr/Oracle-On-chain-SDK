// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "../src/interfaces/ISubscriptionManager.sol";
import {IJobSpecification} from "../src/interfaces/IJob.sol";
import {JobSpecification} from "../src/Job.sol"; // Adjust the path to where your contract is
import {SubscriptionManager} from "../src/SubscriptionManager.sol"; // Adjust the path to where your contract is


contract SubscriptionManagerTest is Test {
    using SafeMath for uint256;

    SubscriptionManager public manager;
    IJobSpecification public jobContract;

    uint256 constant jobType1 = 0;
    uint256 constant jobType2 = 1;
    uint256 constant jobType3 = 2;
    uint256 constant price1 = 0.01 ether;
    uint256 constant price2 = 0.02 ether;
    uint256 constant price3 = 0.03 ether;
    bytes constant taskDescription = "Sample task description";
    bytes constant inputData = hex"00";
    uint256 constant expiration = 3600; // 1 hour

    function setUp() public {
        vm.startPrank(address(0x1));
                vm.deal(address(0x1), 1 ether);
        jobContract = new JobSpecification(address(0));
        manager = new SubscriptionManager(address(jobContract));
    }

    function testSetJobPrice() public {
        manager.setJobPrice(jobType1, price1);
        //correct price set for job type 1
        assert(manager.jobPrices(jobType1) == price1);

        manager.setJobPrice(jobType2, price2);
        assert(manager.jobPrices(jobType2) == price2 );

        manager.setJobPrice(jobType3, price3);
        assert(manager.jobPrices(jobType3) == price3);
    }

    function testRequestJob() public {
        // Set job prices
        manager.setJobPrice(jobType1, price1);
        manager.setJobPrice(jobType2, price2);

        // Request job type 1
        uint256 initialBalance = address(manager).balance;
        manager.requestJob{value: price1}(taskDescription, jobType1, inputData, expiration);
        assert(address(manager).balance == initialBalance.add(price1));

        // Request job type 2
        initialBalance = address(manager).balance;
        manager.requestJob{value: price2}(taskDescription, jobType2, inputData, expiration);
        assert(address(manager).balance == initialBalance.add(price2));
    }

    function testWithdrawPayments() public {
        // Set job prices
        manager.setJobPrice(jobType1, price1);
        manager.setJobPrice(jobType2, price2);

        // Request jobs
        manager.requestJob{value: price1}(taskDescription, jobType1, inputData, expiration);
        manager.requestJob{value: price2}(taskDescription, jobType2, inputData, expiration);

        // Withdraw payments
        uint256 initialBalance = address(manager).balance;
        manager.withdrawPayments();
        assert(address(manager).balance == 0);
    }
}
