// Import necessary modules and contracts
import { SignerWithAddress } from '@nomiclabs/hardhat-ethers/signers'
import { expect } from 'chai'
import { ethers } from 'hardhat'
import {
  CustomOracle,
  SubscriptionManager,
  JobSpecification,
  IJobSpecification,
} from '../typechain'

describe('SubscriptionManager', function () {
  let subscriptionManager: SubscriptionManager
  let jobSpecification: JobSpecification
  let customOracle: CustomOracle
  let SimpleJobHelper
  let owner: SignerWithAddress
  let user: SignerWithAddress
  let offchain_service: SignerWithAddress

  beforeEach(async function () {
    // Deploy contracts and get their instances
    ;[owner, user, offchain_service] = await ethers.getSigners()

    const SimpleJobHelperFactory = await ethers.getContractFactory(
      'SimpleJobHelper',
    )
    SimpleJobHelper = await SimpleJobHelperFactory.deploy()
    await SimpleJobHelper.deployed()

    const JobSpecificationFactory = await ethers.getContractFactory(
      'JobSpecification',
    )
    jobSpecification = await JobSpecificationFactory.deploy(
      ethers.constants.AddressZero,
    )
    await jobSpecification.deployed()

    const SubscriptionManagerFactory = await ethers.getContractFactory(
      'SubscriptionManager',
    )
    subscriptionManager = await SubscriptionManagerFactory.deploy(
      jobSpecification.address,
    )
    await subscriptionManager.deployed()

    const CustomOracleFactory = await ethers.getContractFactory('CustomOracle')
    customOracle = await CustomOracleFactory.deploy(
      '0xe05fcC23807536bEe418f142D19fa0d21BB0cfF7',
      jobSpecification.address,
    )
    await customOracle.deployed()

    await jobSpecification.setTrustedOracle(customOracle.address, true);
  })

  it('should allow user to submit a job and get result from offchain service', async function () {
    //1. first step,  User submits a job and pay for it
    const taskDescription = ethers.utils.toUtf8Bytes('Description of the task')
    const jobType = 0
    const expiration = 3600 // 1 hour
    const payment = ethers.utils.parseEther('0.01') // Payment amount in ethers
    const inputdata = '0x5369676e656420627920307853696c6173';

    await subscriptionManager
      .connect(user)
      .requestJob(taskDescription, jobType, inputdata, expiration, {
        value: payment,
      })

    // Get the event logs
    const logs = await ethers.provider.getLogs({
      fromBlock: 0,
      toBlock: 'latest',
      address: jobSpecification.address,
      topics: [jobSpecification.interface.getEventTopic('JobCreated')],
    })

    // Parse the event logs
    const parsedLogs = logs.map((log) =>
      jobSpecification.interface.parseLog(log),
    )
    expect(parsedLogs[0].name).to.equal('JobCreated')

    // Get the parsed event data
    let jobId = parsedLogs[0].args['jobId']

    //2.Second step,  off-chain serivce find job, compute it and submit to oracle
    const signature = '0x3e06b6798050e7f5f4d7f0bb4bad7647bee76ffffc6c677254c632e6bc9046d36a506e8e7b688e7720742ffb08626682f0860ce1d806b5900a3bcb61aed055111b' // Mock proof for testing
    await customOracle
      .connect(offchain_service)
      .submitAndVerifySignature(jobId, signature)

    // Verify job completion in CustomOracle
    const jobInfo = await jobSpecification.getJob(jobId)
    expect(jobInfo.isCompleted).to.be.true
  })

  // Add more test cases as needed
})
