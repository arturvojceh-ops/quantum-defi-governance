// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface ISecureEnclave {
    function verifyAttestation(bytes32 attestation, address user) external view returns (bool valid);
    function generateAttestation(address user, bytes memory data) external returns (bytes32 attestation);
    function verifyBiometric(address user, bytes memory biometricData) external view returns (bool valid);
    function generateSecureRandom() external returns (uint256 randomNumber);
    function encryptData(bytes memory data, bytes memory publicKey) external returns (bytes memory encryptedData);
    function decryptData(bytes memory encryptedData, bytes memory privateKey) external returns (bytes memory decryptedData);
    function signData(bytes memory data, bytes memory privateKey) external returns (bytes memory signature);
    function verifySignature(bytes memory data, bytes memory signature, bytes memory publicKey) external view returns (bool valid);
    function getDeviceIntegrity(address user) external view returns (bool isSecure);
    function getSecureEnclaveVersion() external view returns (string memory version);
    function isSecureEnclaveAvailable() external view returns (bool available);
}
