# Quantum DeFi Governance

DeFi governance protocol with post-quantum cryptography, zero-knowledge proofs, and hardware security integration.

## Repository

https://github.com/arturvojceh-ops/quantum-defi-governance

## Contracts

- **QuantumGovernanceCore** - Governor with quantum-enhanced voting, ZK proofs, and post-quantum signatures

## Libraries

- **PostQuantumCrypto** - Post-quantum signature verification
- **QuantumCryptography** - Quantum proof generation
- **ZeroKnowledge** - Zero-knowledge proof generation and verification

## Interfaces

- **ISecureEnclave** - Hardware security enclave interface
- **IQuantumRandomness** - Quantum randomness provider interface
- **IZeroKnowledgeProof** - Zero-knowledge proof verifier interface

## Frontend

- Next.js 14 + React 18 + TypeScript
- Tailwind CSS + shadcn/ui
- Wagmi + Viem for Web3
- Zustand for state management

## Setup

```bash
git clone https://github.com/arturvojceh-ops/quantum-defi-governance.git
cd quantum-defi-governance
npm install
cp .env.example .env
npm run dev
```

## Deploy

```bash
npm run deploy:local
```

## License

MIT
