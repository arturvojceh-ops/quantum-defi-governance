// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library ZeroKnowledge {
    uint256 private constant PEDERSEN_G = 1;
    uint256 private constant PEDERSEN_H = 2;
    uint256 private constant FIELD_PRIME = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;
    uint256 private constant CURVE_ORDER = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141;

    struct ZKProof {
        uint256 a;
        uint256 b;
        uint256 c;
        uint256 challenge;
        uint256 response;
        uint256 timestamp;
        address prover;
    }

    struct PedersenCommitment {
        uint256 commitment;
        uint256 randomness;
        uint256 value;
        uint256 timestamp;
        address committer;
    }

    struct RangeProof {
        uint256[] commitments;
        uint256[] challenges;
        uint256[] responses;
        uint256 minValue;
        uint256 maxValue;
        uint256 timestamp;
        address prover;
    }

    struct SigmaProtocol {
        uint256 commitment1;
        uint256 commitment2;
        uint256 challenge;
        uint256 response1;
        uint256 response2;
        uint256 timestamp;
        address prover;
    }

    event ZKProofGenerated(
        address indexed prover,
        uint256 indexed challenge,
        uint256 timestamp
    );

    event PedersenCommitmentCreated(
        address indexed committer,
        uint256 indexed commitment,
        uint256 value,
        uint256 timestamp
    );

    event RangeProofGenerated(
        address indexed prover,
        uint256 indexed minValue,
        uint256 indexed maxValue,
        uint256 timestamp
    );

    error InvalidZKProof();
    error InvalidCommitment();
    error InvalidRange();
    error ChallengeVerificationFailed();
    error ResponseVerificationFailed();
    error InsufficientRandomness();

    function createCommitment(
        uint256 value,
        uint256 randomness,
        address committer
    ) internal view returns (uint256 commitment) {
        uint256 gValue = _modExp(PEDERSEN_G, value, FIELD_PRIME);
        uint256 hRandomness = _modExp(PEDERSEN_H, randomness, FIELD_PRIME);

        commitment = _modMul(gValue, hRandomness, FIELD_PRIME);
        
        emit PedersenCommitmentCreated(committer, commitment, value, block.timestamp);
    }

    function verifyCommitment(
        uint256 commitment,
        uint256 value,
        uint256 randomness
    ) internal view returns (bool valid) {
        uint256 expectedCommitment = createCommitment(value, randomness, msg.sender);
        return commitment == expectedCommitment;
    }

    function generateVotingProof(
        address voterAddress,
        uint256 votingPower,
        uint256 proposalId
    ) internal view returns (ZKProof memory proof) {
        uint256 r1 = _generateRandom(voterAddress, "r1");
        uint256 r2 = _generateRandom(voterAddress, "r2");

        proof.commitment1 = _modExp(PEDERSEN_G, r1, FIELD_PRIME);
        proof.commitment2 = _modExp(PEDERSEN_H, r2, FIELD_PRIME);

        proof.challenge = _generateChallenge(proof.commitment1, proof.commitment2, voterAddress, proposalId);

        proof.response1 = _modAdd(r1, _modMul(votingPower, proof.challenge, FIELD_PRIME), FIELD_PRIME);
        proof.response2 = _modAdd(r2, _modMul(uint256(uint160(voterAddress)), proof.challenge, FIELD_PRIME), FIELD_PRIME);

        proof.timestamp = block.timestamp;
        proof.prover = voterAddress;
        
        emit ZKProofGenerated(voterAddress, proof.challenge, block.timestamp);
    }

    function verifyVotingProof(
        ZKProof memory proof,
        address voterAddress,
        uint256 proposalId
    ) internal view returns (bool valid) {
        uint256 expectedChallenge = _generateChallenge(proof.commitment1, proof.commitment2, voterAddress, proposalId);
        if (proof.challenge != expectedChallenge) {
            revert ChallengeVerificationFailed();
        }

        uint256 gVotingPower = _modExp(PEDERSEN_G, proof.response1, FIELD_PRIME);
        uint256 hVoterAddress = _modExp(PEDERSEN_H, proof.response2, FIELD_PRIME);
        
        uint256 expectedCommitment1 = _modMul(
            proof.commitment1,
            _modExp(_modExp(PEDERSEN_G, uint256(uint160(voterAddress)), FIELD_PRIME), proof.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        uint256 expectedCommitment2 = _modMul(
            proof.commitment2,
            _modExp(_modExp(PEDERSEN_H, uint256(uint160(voterAddress)), FIELD_PRIME), proof.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        return gVotingPower == expectedCommitment1 && hVoterAddress == expectedCommitment2;
    }

    function generateRangeProof(
        uint256 value,
        uint256 minValue,
        uint256 maxValue,
        address prover
    ) internal view returns (RangeProof memory rangeProof) {
        if (value < minValue || value > maxValue) {
            revert InvalidRange();
        }

        uint256 range = maxValue - minValue;
        uint256 numBits = _calculateRequiredBits(range);
        
        rangeProof.commitments = new uint256[](numBits);
        rangeProof.challenges = new uint256[](numBits);
        rangeProof.responses = new uint256[](numBits);

        for (uint256 i = 0; i < numBits; i++) {
            uint256 bit = (value >> i) & 1;
            uint256 randomness = _generateRandom(prover, abi.encodePacked("bit", i));
            
            rangeProof.commitments[i] = createCommitment(bit, randomness, prover);
            rangeProof.challenges[i] = _generateChallenge(
                rangeProof.commitments[i],
                prover,
                i,
                block.timestamp
            );
            rangeProof.responses[i] = _modAdd(randomness, _modMul(bit, rangeProof.challenges[i], FIELD_PRIME), FIELD_PRIME);
        }

        rangeProof.minValue = minValue;
        rangeProof.maxValue = maxValue;
        rangeProof.timestamp = block.timestamp;
        rangeProof.prover = prover;
        
        emit RangeProofGenerated(prover, minValue, maxValue, block.timestamp);
    }

    function verifyRangeProof(
        RangeProof memory rangeProof,
        address prover
    ) internal view returns (bool valid) {
        for (uint256 i = 0; i < rangeProof.commitments.length; i++) {
            uint256 expectedChallenge = _generateChallenge(
                rangeProof.commitments[i],
                prover,
                i,
                rangeProof.timestamp
            );
            
            if (rangeProof.challenges[i] != expectedChallenge) {
                return false;
            }

            uint256 reconstructedCommitment = createCommitment(
                0,
                rangeProof.responses[i],
                prover
            );
            
            if (rangeProof.commitments[i] != reconstructedCommitment) {
                return false;
            }
        }
        
        return true;
    }

    function generateSigmaProtocol(
        uint256 secret,
        uint256 publicValue,
        address prover
    ) internal view returns (SigmaProtocol memory sigmaProtocol) {
        uint256 k1 = _generateRandom(prover, "k1");
        uint256 k2 = _generateRandom(prover, "k2");

        sigmaProtocol.commitment1 = _modExp(PEDERSEN_G, k1, FIELD_PRIME);
        sigmaProtocol.commitment2 = _modExp(PEDERSEN_H, k2, FIELD_PRIME);

        sigmaProtocol.challenge = _generateChallenge(
            sigmaProtocol.commitment1,
            sigmaProtocol.commitment2,
            publicValue,
            prover
        );
        
        sigmaProtocol.response1 = _modAdd(k1, _modMul(secret, sigmaProtocol.challenge, FIELD_PRIME), FIELD_PRIME);
        sigmaProtocol.response2 = _modAdd(k2, _modMul(publicValue, sigmaProtocol.challenge, FIELD_PRIME), FIELD_PRIME);

        sigmaProtocol.timestamp = block.timestamp;
        sigmaProtocol.prover = prover;
    }

    function verifySigmaProtocol(
        SigmaProtocol memory sigmaProtocol,
        uint256 publicValue,
        address prover
    ) internal view returns (bool valid) {
        uint256 expectedChallenge = _generateChallenge(
            sigmaProtocol.commitment1,
            sigmaProtocol.commitment2,
            publicValue,
            prover
        );

        if (sigmaProtocol.challenge != expectedChallenge) {
            return false;
        }

        uint256 gResponse1 = _modExp(PEDERSEN_G, sigmaProtocol.response1, FIELD_PRIME);
        uint256 hResponse2 = _modExp(PEDERSEN_H, sigmaProtocol.response2, FIELD_PRIME);
        
        uint256 expectedCommitment1 = _modMul(
            sigmaProtocol.commitment1,
            _modExp(_modExp(PEDERSEN_G, publicValue, FIELD_PRIME), sigmaProtocol.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        uint256 expectedCommitment2 = _modMul(
            sigmaProtocol.commitment2,
            _modExp(_modExp(PEDERSEN_H, publicValue, FIELD_PRIME), sigmaProtocol.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        return gResponse1 == expectedCommitment1 && hResponse2 == expectedCommitment2;
    }

    function _generateRandom(
        address seed,
        bytes memory additionalData
    ) private view returns (uint256 random) {
        return uint256(keccak256(abi.encodePacked(seed, block.timestamp, block.difficulty, additionalData)));
    }

    function _generateChallenge(
        uint256 commitment1,
        uint256 commitment2,
        address additionalData
    ) private view returns (uint256 challenge) {
        return uint256(keccak256(abi.encodePacked(commitment1, commitment2, additionalData, block.timestamp)));
    }

    function _generateChallenge(
        uint256 commitment1,
        uint256 commitment2,
        address voterAddress,
        uint256 proposalId
    ) private view returns (uint256 challenge) {
        return uint256(keccak256(abi.encodePacked(
            commitment1,
            commitment2,
            voterAddress,
            proposalId,
            block.timestamp
        )));
    }

    function _generateChallenge(
        uint256 commitment,
        address prover,
        uint256 index,
        uint256 timestamp
    ) private view returns (uint256 challenge) {
        return uint256(keccak256(abi.encodePacked(
            commitment,
            prover,
            index,
            timestamp
        )));
    }

    function _modExp(
        uint256 base,
        uint256 exponent,
        uint256 modulus
    ) private pure returns (uint256 result) {
        assembly {
            let m := mload(0x40)
            mstore(m, 0x20)
            mstore(add(m, 0x20), 0x20)
            mstore(add(m, 0x40), 0x20)
            mstore(add(m, 0x60), base)
            mstore(add(m, 0x80), exponent)
            mstore(add(m, 0xa0), modulus)

            let success := staticcall(gas(), 0x05, m, 0xc0, m, 0x20)

            if iszero(success) {
                revert(0, 0)
            }

            result := mload(m)
        }
    }

    function _modMul(
        uint256 a,
        uint256 b,
        uint256 modulus
    ) private pure returns (uint256 result) {
        return _modExp(a, b, modulus);
    }

    function _modAdd(
        uint256 a,
        uint256 b,
        uint256 modulus
    ) private pure returns (uint256 result) {
        uint256 sum = a + b;
        if (sum >= modulus) {
            sum -= modulus;
        }
        return sum;
    }

    function _calculateRequiredBits(uint256 range) private pure returns (uint256 bits) {
        bits = 0;
        while (range > 0) {
            range >>= 1;
            bits++;
        }
        return bits;
    }

    function generateBalanceProof(
        address account,
        uint256 balance,
        uint256 minBalance
    ) internal view returns (ZKProof memory proof) {
        uint256 r1 = _generateRandom(account, "balance_r1");
        uint256 r2 = _generateRandom(account, "balance_r2");

        proof.commitment1 = _modExp(PEDERSEN_G, r1, FIELD_PRIME);
        proof.commitment2 = _modExp(PEDERSEN_H, r2, FIELD_PRIME);

        proof.challenge = _generateChallenge(
            proof.commitment1,
            proof.commitment2,
            account,
            balance
        );
        
        proof.response1 = _modAdd(r1, _modMul(balance, proof.challenge, FIELD_PRIME), FIELD_PRIME);
        proof.response2 = _modAdd(r2, _modMul(minBalance, proof.challenge, FIELD_PRIME), FIELD_PRIME);

        proof.timestamp = block.timestamp;
        proof.prover = account;
        
        emit ZKProofGenerated(account, proof.challenge, block.timestamp);
    }

    function verifyBalanceProof(
        ZKProof memory proof,
        address account,
        uint256 minBalance
    ) internal view returns (bool valid) {
        uint256 expectedChallenge = _generateChallenge(
            proof.commitment1,
            proof.commitment2,
            account,
            minBalance
        );

        if (proof.challenge != expectedChallenge) {
            return false;
        }

        uint256 gBalance = _modExp(PEDERSEN_G, proof.response1, FIELD_PRIME);
        uint256 hMinBalance = _modExp(PEDERSEN_H, proof.response2, FIELD_PRIME);
        
        uint256 expectedCommitment1 = _modMul(
            proof.commitment1,
            _modExp(_modExp(PEDERSEN_G, minBalance, FIELD_PRIME), proof.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        uint256 expectedCommitment2 = _modMul(
            proof.commitment2,
            _modExp(_modExp(PEDERSEN_H, uint256(uint160(account)), FIELD_PRIME), proof.challenge, FIELD_PRIME),
            FIELD_PRIME
        );
        
        return gBalance == expectedCommitment1 && hMinBalance == expectedCommitment2;
    }
}
