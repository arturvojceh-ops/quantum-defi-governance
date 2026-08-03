// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IQuantumRandomness {
    function requestRandomness() external returns (uint256 requestId);
    function getRandomness(uint256 requestId) external view returns (bytes32 randomness);
    function getLatestRandomness() external view returns (bytes32 randomness);
    function verifyQuantumRandomness(bytes32 randomness, bytes memory proof) external view returns (bool valid);
    function getRandomnessStatistics() external view returns (uint256 totalRequests, uint256 successfulRequests, uint256 averageEntropy);
    function isQuantumRandomnessAvailable() external view returns (bool available);
    function getQuantumSourceInfo() external view returns (string memory source, string memory version);
    function generateMultipleRandomness(uint256 count) external returns (bytes32[] memory randomNumbers);
    function getRandomnessWithEntropy(uint256 entropy) external returns (bytes32 randomness);
    function verifyRandomnessBatch(bytes32[] memory randomnessArray, bytes[] memory proofs) external view returns (bool[] memory validArray);
    function getRandomnessWithTimestamp() external view returns (bytes32 randomness, uint256 timestamp);
    function cancelRandomnessRequest(uint256 requestId) external returns (bool success);
    function getRequestStatus(uint256 requestId) external view returns (uint8 status);
}
