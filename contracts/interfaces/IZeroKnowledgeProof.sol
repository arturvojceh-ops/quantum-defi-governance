// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IZeroKnowledgeProof
 * @dev Interface for zero-knowledge proof verification
 * @notice This interface provides access to zero-knowledge proof systems
 * for privacy-preserving governance operations
 */
interface IZeroKnowledgeProof {
    /**
     * @dev Verifies a zero-knowledge proof
     * @param proof The zero-knowledge proof
     * @return valid Whether the proof is valid
     */
    function verifyProof(bytes memory proof) external view returns (bool valid);

    /**
     * @dev Verifies a zk-SNARK proof
     * @param proof The zk-SNARK proof
     * @param publicInputs The public inputs
     * @return valid Whether the proof is valid
     */
    function verifySNARKProof(
        bytes memory proof,
        uint256[] memory publicInputs
    ) external view returns (bool valid);

    /**
     * @dev Verifies a zk-STARK proof
     * @param proof The zk-STARK proof
     * @param publicInputs The public inputs
     * @return valid Whether the proof is valid
     */
    function verifySTARKProof(
        bytes memory proof,
        uint256[] memory publicInputs
    ) external view returns (bool valid);

    /**
     * @dev Verifies a Bulletproof
     * @param proof The Bulletproof
     * @param commitment The commitment
     * @return valid Whether the proof is valid
     */
    function verifyBulletproof(
        bytes memory proof,
        bytes32 commitment
    ) external view returns (bool valid);

    /**
     * @dev Creates a zero-knowledge commitment
     * @param value The value to commit to
     * @param randomness The randomness value
     * @return commitment The commitment
     */
    function createCommitment(
        uint256 value,
        bytes32 randomness
    ) external returns (bytes32 commitment);

    /**
     * @dev Verifies a commitment
     * @param commitment The commitment to verify
     * @param value The original value
     * @param randomness The randomness value
     * @return valid Whether the commitment is valid
     */
    function verifyCommitment(
        bytes32 commitment,
        uint256 value,
        bytes32 randomness
    ) external view returns (bool valid);

    /**
     * @dev Generates a zero-knowledge proof for voting
     * @param voterAddress The voter address
     * @param votingPower The voting power
     * @param proposalId The proposal ID
     * @return proof The generated proof
     */
    function generateVotingProof(
        address voterAddress,
        uint256 votingPower,
        uint256 proposalId
    ) external returns (bytes memory proof);

    /**
     * @dev Verifies a voting proof
     * @param proof The voting proof
     * @param voterAddress The voter address
     * @param proposalId The proposal ID
     * @return valid Whether the proof is valid
     */
    function verifyVotingProof(
        bytes memory proof,
        address voterAddress,
        uint256 proposalId
    ) external view returns (bool valid);

    /**
     * @dev Generates a zero-knowledge proof for balance
     * @param account The account address
     * @param balance The account balance
     * @return proof The generated proof
     */
    function generateBalanceProof(
        address account,
        uint256 balance
    ) external returns (bytes memory proof);

    /**
     * @dev Verifies a balance proof
     * @param proof The balance proof
     * @param account The account address
     * @return valid Whether the proof is valid
     */
    function verifyBalanceProof(
        bytes memory proof,
        address account
    ) external view returns (bool valid);

    /**
     * @dev Generates a zero-knowledge proof for identity
     * @param identityData The identity data
     * @return proof The generated proof
     */
    function generateIdentityProof(
        bytes memory identityData
    ) external returns (bytes memory proof);

    /**
     * @dev Verifies an identity proof
     * @param proof The identity proof
     * @param identityHash The identity hash
     * @return valid Whether the proof is valid
     */
    function verifyIdentityProof(
        bytes memory proof,
        bytes32 identityHash
    ) external view returns (bool valid);

    /**
     * @dev Gets zero-knowledge proof system information
     * @return system The proof system name
     * @return version The proof system version
     * @return securityLevel The security level
     */
    function getProofSystemInfo() external view returns (
        string memory system,
        string memory version,
        uint256 securityLevel
    );

    /**
     * @dev Checks if zero-knowledge proof system is available
     * @return available Whether the system is available
     */
    function isProofSystemAvailable() external view returns (bool available);

    /**
     * @dev Gets proof verification cost
     * @return gasCost The gas cost for verification
     */
    function getProofVerificationCost() external view returns (uint256 gasCost);

    /**
     * @dev Generates a zero-knowledge proof batch
     * @param inputs Array of input values
     * @return proofs Array of generated proofs
     */
    function generateProofBatch(
        uint256[] memory inputs
    ) external returns (bytes[] memory proofs);

    /**
     * @dev Verifies a zero-knowledge proof batch
     * @param proofs Array of proofs
     * @param publicInputs Array of public inputs
     * @return validArray Array of validity results
     */
    function verifyProofBatch(
        bytes[] memory proofs,
        uint256[][] memory publicInputs
    ) external view returns (bool[] memory validArray);

    /**
     * @dev Gets zero-knowledge proof statistics
     * @return totalProofs Total number of proofs generated
     * @return successfulVerifications Total number of successful verifications
     * @return averageProofSize Average proof size
     */
    function getProofStatistics() external view returns (
        uint256 totalProofs,
        uint256 successfulVerifications,
        uint256 averageProofSize
    );
}
