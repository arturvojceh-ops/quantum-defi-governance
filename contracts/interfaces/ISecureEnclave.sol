// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
 * @title ISecureEnclave
 * @dev Interface for secure enclave integration
 * @notice This interface provides access to hardware security features
 * like Apple Secure Enclave, Intel SGX, and ARM TrustZone
 */
interface ISecureEnclave {
    /**
     * @dev Verifies an attestation from secure enclave
     * @param attestation The attestation data
     * @param user The user address
     * @return valid Whether the attestation is valid
     */
    function verifyAttestation(
        bytes32 attestation,
        address user
    ) external view returns (bool valid);

    /**
     * @dev Generates a secure attestation
     * @param user The user address
     * @param data The data to attest
     * @return attestation The generated attestation
     */
    function generateAttestation(
        address user,
        bytes memory data
    ) external returns (bytes32 attestation);

    /**
     * @dev Verifies biometric authentication
     * @param user The user address
     * @param biometricData The biometric data
     * @return valid Whether the biometric authentication is valid
     */
    function verifyBiometric(
        address user,
        bytes memory biometricData
    ) external view returns (bool valid);

    /**
     * @dev Generates a secure random number
     * @return randomNumber The secure random number
     */
    function generateSecureRandom() external returns (uint256 randomNumber);

    /**
     * @dev Encrypts data using secure enclave
     * @param data The data to encrypt
     * @param publicKey The public key for encryption
     * @return encryptedData The encrypted data
     */
    function encryptData(
        bytes memory data,
        bytes memory publicKey
    ) external returns (bytes memory encryptedData);

    /**
     * @dev Decrypts data using secure enclave
     * @param encryptedData The encrypted data
     * @param privateKey The private key for decryption
     * @return decryptedData The decrypted data
     */
    function decryptData(
        bytes memory encryptedData,
        bytes memory privateKey
    ) external returns (bytes memory decryptedData);

    /**
     * @dev Signs data using secure enclave
     * @param data The data to sign
     * @param privateKey The private key for signing
     * @return signature The generated signature
     */
    function signData(
        bytes memory data,
        bytes memory privateKey
    ) external returns (bytes memory signature);

    /**
     * @dev Verifies signature using secure enclave
     * @param data The original data
     * @param signature The signature to verify
     * @param publicKey The public key for verification
     * @return valid Whether the signature is valid
     */
    function verifySignature(
        bytes memory data,
        bytes memory signature,
        bytes memory publicKey
    ) external view returns (bool valid);

    /**
     * @dev Gets device integrity status
     * @param user The user address
     * @return isSecure Whether the device is secure
     */
    function getDeviceIntegrity(
        address user
    ) external view returns (bool isSecure);

    /**
     * @dev Gets secure enclave version
     * @return version The secure enclave version
     */
    function getSecureEnclaveVersion() external view returns (string memory version);

    /**
     * @dev Checks if secure enclave is available
     * @return available Whether the secure enclave is available
     */
    function isSecureEnclaveAvailable() external view returns (bool available);
}
