// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IZeroKnowledgeProof {
    function verifyProof(bytes memory proof) external view returns (bool valid);
    function verifySNARKProof(bytes memory proof, uint256[] memory publicInputs) external view returns (bool valid);
    function verifySTARKProof(bytes memory proof, uint256[] memory publicInputs) external view returns (bool valid);
    function verifyBulletproof(bytes memory proof, bytes32 commitment) external view returns (bool valid);
    function createCommitment(uint256 value, bytes32 randomness) external returns (bytes32 commitment);
    function verifyCommitment(bytes32 commitment, uint256 value, bytes32 randomness) external view returns (bool valid);
    function generateVotingProof(address voterAddress, uint256 votingPower, uint256 proposalId) external returns (bytes memory proof);
    function verifyVotingProof(bytes memory proof, address voterAddress, uint256 proposalId) external view returns (bool valid);
    function generateBalanceProof(address account, uint256 balance) external returns (bytes memory proof);
    function verifyBalanceProof(bytes memory proof, address account) external view returns (bool valid);
    function generateIdentityProof(bytes memory identityData) external returns (bytes memory proof);
    function verifyIdentityProof(bytes memory proof, bytes32 identityHash) external view returns (bool valid);
    function getProofSystemInfo() external view returns (string memory system, string memory version, uint256 securityLevel);
    function isProofSystemAvailable() external view returns (bool available);
    function getProofVerificationCost() external view returns (uint256 gasCost);
    function generateProofBatch(uint256[] memory inputs) external returns (bytes[] memory proofs);
    function verifyProofBatch(bytes[] memory proofs, uint256[][] memory publicInputs) external view returns (bool[] memory validArray);
    function getProofStatistics() external view returns (uint256 totalProofs, uint256 successfulVerifications, uint256 averageProofSize);
}
