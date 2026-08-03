// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library PostQuantumCrypto {
    uint256 private constant KYBER_PUBLIC_KEY_SIZE = 800;
    uint256 private constant KYBER_PRIVATE_KEY_SIZE = 1632;
    uint256 private constant KYBER_CIPHERTEXT_SIZE = 768;
    uint256 private constant DILITHIUM_SIGNATURE_SIZE = 2420;
    uint256 private constant SPHINCS_SIGNATURE_SIZE = 17088;
    uint256 private constant MCELIECE_PUBLIC_KEY_SIZE = 261120;
    uint256 private constant MCELIECE_PRIVATE_KEY_SIZE = 6492;

    struct PostQuantumKeyPair {
        bytes publicKey;
        bytes privateKey;
        uint256 keyType;
        uint256 keyVersion;
        uint256 generatedAt;
    }

    struct PostQuantumSignature {
        bytes signature;
        uint256 signatureType;
        uint256 timestamp;
        address signer;
    }

    struct PostQuantumCiphertext {
        bytes ciphertext;
        bytes encapsulatedKey;
        uint256 algorithm;
        uint256 timestamp;
    }

    event PostQuantumKeyPairGenerated(
        address indexed owner,
        uint256 indexed keyType,
        uint256 indexed keyVersion,
        uint256 timestamp
    );

    event PostQuantumSignatureCreated(
        address indexed signer,
        uint256 indexed signatureType,
        bytes32 indexed messageHash,
        uint256 timestamp
    );

    event PostQuantumEncryptionCompleted(
        address indexed recipient,
        uint256 indexed algorithm,
        uint256 timestamp
    );

    error InvalidPostQuantumKey();
    error PostQuantumSignatureInvalid();
    error PostQuantumEncryptionFailed();
    error PostQuantumDecryptionFailed();
    error UnsupportedAlgorithm();
    error InvalidKeySize();

    function generateKyberKeyPair(
        address user
    ) internal returns (PostQuantumKeyPair memory keyPair) {
        bytes32 entropy = keccak256(abi.encodePacked(user, block.timestamp, block.number));

        keyPair.publicKey = new bytes(KYBER_PUBLIC_KEY_SIZE);
        for (uint256 i = 0; i < KYBER_PUBLIC_KEY_SIZE; i++) {
            keyPair.publicKey[i] = bytes1(uint8(entropy >> (i * 8)));
        }

        keyPair.privateKey = new bytes(KYBER_PRIVATE_KEY_SIZE);
        for (uint256 i = 0; i < KYBER_PRIVATE_KEY_SIZE; i++) {
            keyPair.privateKey[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(entropy, i))) >> (i * 8)));
        }

        keyPair.keyType = 1;
        keyPair.keyVersion = 1;
        keyPair.generatedAt = block.timestamp;
        
        emit PostQuantumKeyPairGenerated(user, keyPair.keyType, keyPair.keyVersion, keyPair.generatedAt);
    }

    function generateDilithiumKeyPair(
        address user
    ) internal returns (PostQuantumKeyPair memory keyPair) {
        bytes32 entropy = keccak256(abi.encodePacked(user, block.timestamp, block.number, "dilithium"));

        keyPair.publicKey = new bytes(1312);
        for (uint256 i = 0; i < 1312; i++) {
            keyPair.publicKey[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(entropy, i))) >> (i * 8)));
        }

        keyPair.privateKey = new bytes(2528);
        for (uint256 i = 0; i < 2528; i++) {
            keyPair.privateKey[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(entropy, i + 1312))) >> (i * 8)));
        }

        keyPair.keyType = 2;
        keyPair.keyVersion = 1;
        keyPair.generatedAt = block.timestamp;
        
        emit PostQuantumKeyPairGenerated(user, keyPair.keyType, keyPair.keyVersion, keyPair.generatedAt);
    }

    function generateSphincsKeyPair(
        address user
    ) internal returns (PostQuantumKeyPair memory keyPair) {
        bytes32 entropy = keccak256(abi.encodePacked(user, block.timestamp, block.number, "sphincs"));

        keyPair.publicKey = new bytes(32);
        for (uint256 i = 0; i < 32; i++) {
            keyPair.publicKey[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(entropy, i))) >> (i * 8)));
        }

        keyPair.privateKey = new bytes(64);
        for (uint256 i = 0; i < 64; i++) {
            keyPair.privateKey[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(entropy, i + 32))) >> (i * 8)));
        }

        keyPair.keyType = 3;
        keyPair.keyVersion = 1;
        keyPair.generatedAt = block.timestamp;
        
        emit PostQuantumKeyPairGenerated(user, keyPair.keyType, keyPair.keyVersion, keyPair.generatedAt);
    }

    function signMessage(
        bytes32 messageHash,
        bytes memory privateKey,
        uint256 signatureType
    ) internal view returns (bytes memory signature) {
        if (signatureType == 1) {
            signature = new bytes(DILITHIUM_SIGNATURE_SIZE);
            for (uint256 i = 0; i < DILITHIUM_SIGNATURE_SIZE; i++) {
                signature[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(messageHash, privateKey, i))) >> (i * 8)));
            }
        } else if (signatureType == 2) {
            signature = new bytes(SPHINCS_SIGNATURE_SIZE);
            for (uint256 i = 0; i < SPHINCS_SIGNATURE_SIZE; i++) {
                signature[i] = bytes1(uint8(uint256(keccak256(abi.encodePacked(messageHash, privateKey, i))) >> (i * 8)));
            }
        } else {
            revert UnsupportedAlgorithm();
        }
        
        emit PostQuantumSignatureCreated(msg.sender, signatureType, messageHash, block.timestamp);
    }

    function verifySignature(
        bytes32 messageHash,
        bytes memory signature,
        bytes memory publicKey
    ) internal pure returns (bool valid) {
        bytes32 expectedHash = keccak256(abi.encodePacked(messageHash, publicKey));

        bytes32 signatureHash;
        assembly {
            signatureHash := mload(add(signature, 32))
        }
        
        return signatureHash == expectedHash;
    }

    function encryptData(
        bytes memory plaintext,
        bytes memory publicKey,
        uint256 algorithm
    ) internal view returns (PostQuantumCiphertext memory ciphertext) {
        if (algorithm != 1) {
            revert UnsupportedAlgorithm();
        }
        
        bytes32 encapsulatedKey = keccak256(abi.encodePacked(publicKey, block.timestamp, "encapsulation"));

        ciphertext.ciphertext = new bytes(plaintext.length);
        for (uint256 i = 0; i < plaintext.length; i++) {
            ciphertext.ciphertext[i] = bytes1(uint8(plaintext[i]) ^ uint8(uint256(keccak256(abi.encodePacked(encapsulatedKey, i))) >> (i * 8)));
        }

        ciphertext.encapsulatedKey = abi.encodePacked(encapsulatedKey);
        ciphertext.algorithm = algorithm;
        ciphertext.timestamp = block.timestamp;
        
        emit PostQuantumEncryptionCompleted(msg.sender, algorithm, block.timestamp);
    }

    function decryptData(
        PostQuantumCiphertext memory ciphertext,
        bytes memory privateKey
    ) internal pure returns (bytes memory plaintext) {
        bytes32 encapsulatedKey;
        assembly {
            encapsulatedKey := mload(add(ciphertext.encapsulatedKey, 32))
        }

        plaintext = new bytes(ciphertext.ciphertext.length);
        for (uint256 i = 0; i < ciphertext.ciphertext.length; i++) {
            plaintext[i] = bytes1(uint8(ciphertext.ciphertext[i]) ^ uint8(uint256(keccak256(abi.encodePacked(encapsulatedKey, i))) >> (i * 8)));
        }
    }

    function encapsulate(
        bytes memory publicKey
    ) internal view returns (bytes memory encapsulatedKey, bytes memory sharedSecret) {
        encapsulatedKey = abi.encodePacked(keccak256(abi.encodePacked(publicKey, block.timestamp, "encapsulation")));

        sharedSecret = abi.encodePacked(keccak256(abi.encodePacked(encapsulatedKey, publicKey, "shared_secret")));
    }

    function decapsulate(
        bytes memory encapsulatedKey,
        bytes memory privateKey
    ) internal pure returns (bytes memory sharedSecret) {
        sharedSecret = abi.encodePacked(keccak256(abi.encodePacked(encapsulatedKey, privateKey, "shared_secret")));
    }

    function validateKeySize(
        bytes memory publicKey,
        uint256 keyType
    ) internal pure returns (bool valid) {
        if (keyType == 1) {
            return publicKey.length == KYBER_PUBLIC_KEY_SIZE;
        } else if (keyType == 2) {
            return publicKey.length == 1312;
        } else if (keyType == 3) {
            return publicKey.length == 32;
        } else if (keyType == 4) {
            return publicKey.length == MCELIECE_PUBLIC_KEY_SIZE;
        } else {
            return false;
        }
    }

    function getAlgorithmInfo(
        uint256 algorithm
    ) internal pure returns (string memory name, uint256 keySize, uint256 securityLevel) {
        if (algorithm == 1) {
            return ("Kyber", KYBER_PUBLIC_KEY_SIZE, 128);
        } else if (algorithm == 2) {
            return ("Dilithium", 1312, 128);
        } else if (algorithm == 3) {
            return ("SPHINCS+", 32, 128);
        } else if (algorithm == 4) {
            return ("McEliece", MCELIECE_PUBLIC_KEY_SIZE, 256);
        } else {
            revert UnsupportedAlgorithm();
        }
    }

    function computeHash(
        bytes memory data
    ) internal view returns (bytes32 hash) {
        return keccak256(abi.encodePacked(data, "post_quantum", block.timestamp));
    }

    function generateRandomNumber(
        bytes32 seed
    ) internal view returns (uint256 randomNumber) {
        return uint256(keccak256(abi.encodePacked(seed, block.timestamp, block.difficulty, "post_quantum_random")));
    }

    function deriveKey(
        bytes32 seed,
        uint256 keyType,
        uint256 keyIndex
    ) internal pure returns (bytes memory key) {
        return abi.encodePacked(seed, keyType, keyIndex, "post_quantum_derivation");
    }

    function validateSignatureFormat(
        bytes memory signature,
        uint256 signatureType
    ) internal pure returns (bool valid) {
        if (signatureType == 1) {
            return signature.length == DILITHIUM_SIGNATURE_SIZE;
        } else if (signatureType == 2) {
            return signature.length == SPHINCS_SIGNATURE_SIZE;
        } else {
            return false;
        }
    }

    function getSecurityLevel(uint256 algorithm) internal pure returns (uint256 securityLevel) {
        if (algorithm == 1) {
            return 128;
        } else if (algorithm == 2) {
            return 128;
        } else if (algorithm == 3) {
            return 128;
        } else if (algorithm == 4) {
            return 256;
        } else {
            revert UnsupportedAlgorithm();
        }
    }
}
