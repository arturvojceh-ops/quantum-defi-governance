// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title IQuantumRandomness
 * @dev Interface for quantum randomness generation
 * @notice This interface provides access to true quantum randomness
 * from quantum computing sources
 */
interface IQuantumRandomness {
    /**
     * @dev Requests quantum randomness
     * @return requestId The request ID for the randomness
     */
    function requestRandomness() external returns (uint256 requestId);

    /**
     * @dev Gets quantum randomness for a request ID
     * @param requestId The request ID
     * @return randomness The quantum randomness
     */
    function getRandomness(uint256 requestId) external view returns (bytes32 randomness);

    /**
     * @dev Gets the latest quantum randomness
     * @return randomness The latest quantum randomness
     */
    function getLatestRandomness() external view returns (bytes32 randomness);

    /**
     * @dev Verifies quantum randomness
     * @param randomness The randomness to verify
     * @param proof The proof of quantum origin
     * @return valid Whether the randomness is valid
     */
    function verifyQuantumRandomness(
        bytes32 randomness,
        bytes memory proof
    ) external view returns (bool valid);

    /**
     * @dev Gets quantum randomness statistics
     * @return totalRequests Total number of requests
     * @return successfulRequests Total number of successful requests
     * @return averageEntropy Average entropy of randomness
     */
    function getRandomnessStatistics() external view returns (
        uint256 totalRequests,
        uint256 successfulRequests,
        uint256 averageEntropy
    );

    /**
     * @dev Checks if quantum randomness is available
     * @return available Whether quantum randomness is available
     */
    function isQuantumRandomnessAvailable() external view returns (bool available);

    /**
     * @dev Gets the quantum source information
     * @return source The quantum source
     * @return version The quantum source version
     */
    function getQuantumSourceInfo() external view returns (string memory source, string memory version);

    /**
     * @dev Generates multiple quantum random numbers
     * @param count The number of random numbers to generate
     * @return randomNumbers Array of quantum random numbers
     */
    function generateMultipleRandomness(uint256 count) external returns (bytes32[] memory randomNumbers);

    /**
     * @dev Gets quantum randomness with custom entropy
     * @param entropy The custom entropy level
     * @return randomness The quantum randomness with custom entropy
     */
    function getRandomnessWithEntropy(uint256 entropy) external returns (bytes32 randomness);

    /**
     * @dev Verifies quantum randomness batch
     * @param randomnessArray Array of randomness values
     * @param proofs Array of proofs
     * @return validArray Array of validity results
     */
    function verifyRandomnessBatch(
        bytes32[] memory randomnessArray,
        bytes[] memory proofs
    ) external view returns (bool[] memory validArray);

    /**
     * @dev Gets quantum randomness with timestamp
     * @return randomness The quantum randomness
     * @return timestamp The timestamp of generation
     */
    function getRandomnessWithTimestamp() external view returns (bytes32 randomness, uint256 timestamp);

    /**
     * @dev Cancels a quantum randomness request
     * @param requestId The request ID to cancel
     * @return success Whether the cancellation was successful
     */
    function cancelRandomnessRequest(uint256 requestId) external returns (bool success);

    /**
     * @dev Gets quantum randomness request status
     * @param requestId The request ID
     * @return status The request status
     */
    function getRequestStatus(uint256 requestId) external view returns (uint8 status);
}
