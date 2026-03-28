# 🚀 Quantum DeFi Governance - Installation & Setup Guide

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v18.0.0 or higher)
- **npm** (v9.0.0 or higher) or **yarn** (v1.22.0 or higher)
- **Git** (latest version)
- **Rust** (v1.75.0 or higher) - for WebAssembly compilation
- **Docker** (latest version) - for containerization
- **Foundry** - for smart contract development

## 🛠️ Quick Start

### 1. Clone the Repository

```bash
git clone https://github.com/arturvojceh-ops/quantum-defi-governance.git
cd quantum-defi-governance
```

### 2. Install Dependencies

```bash
# Install Node.js dependencies
npm install

# Install Foundry dependencies
forge install

# Install Rust and WebAssembly dependencies
rustup update stable
cargo install wasm-pack
```

### 3. Environment Setup

```bash
# Copy environment template
cp .env.example .env

# Edit environment variables
nano .env
```

### 4. Start Development

```bash
# Start the frontend development server
npm run dev

# Start the smart contract local node (in another terminal)
npm run node:local

# Deploy contracts locally (in another terminal)
npm run deploy:local
```

## 🔧 Detailed Setup

### Environment Variables

Create a `.env` file with the following variables:

```env
# Blockchain Configuration
NEXT_PUBLIC_CHAIN_ID=1
NEXT_PUBLIC_RPC_URL=https://mainnet.infura.io/v3/YOUR_INFURA_ID
NEXT_PUBLIC_WSS_URL=wss://mainnet.infura.io/ws/v3/YOUR_INFURA_ID
NEXT_PUBLIC_INFURA_ID=your_infura_id
NEXT_PUBLIC_ETHERSCAN_API_KEY=your_etherscan_api_key

# IPFS Configuration
NEXT_PUBLIC_PINATA_API_KEY=your_pinata_api_key
NEXT_PUBLIC_PINATA_SECRET=your_pinata_secret

# Arweave Configuration
NEXT_PUBLIC_ARWEAVE_KEY=your_arweave_key

# Quantum Services
NEXT_PUBLIC_QUANTUM_API_URL=https://api.quantum-computing.com
NEXT_PUBLIC_SECURE_ENCLAVE_URL=https://secure-enclave.apple.com

# Analytics & Monitoring
NEXT_PUBLIC_ANALYTICS_ID=your_analytics_id
NEXT_PUBLIC_SENTRY_DSN=your_sentry_dsn

# Development
NODE_ENV=development
```

### Smart Contract Development

```bash
# Compile contracts
npm run compile

# Run tests
npm run test

# Run gas report
npm run gas-report

# Run security audit
npm run security:check

# Deploy to local network
npm run deploy:local

# Deploy to testnet
npm run deploy:goerli

# Deploy to mainnet
npm run deploy:mainnet
```

### Frontend Development

```bash
# Start development server
npm run dev

# Build for production
npm run build

# Start production server
npm run start

# Run linting
npm run lint

# Run type checking
npm run type-check

# Run tests
npm run test:unit
npm run test:integration
npm run test:e2e
```

### WebAssembly Development

```bash
# Build WebAssembly module
npm run build:wasm

# Test WebAssembly module
npm run test:wasm

# Watch for changes
cd rust
cargo watch
```

## 🐳 Docker Setup

### Build Docker Image

```bash
# Build the application
docker build -t quantum-defi-governance .

# Run the container
docker run -p 3000:3000 quantum-defi-governance
```

### Docker Compose

```bash
# Start all services
docker-compose up -d

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

## ☸️ Kubernetes Setup

### Deploy to Kubernetes

```bash
# Apply all configurations
kubectl apply -f k8s/

# Check deployment status
kubectl get pods

# View logs
kubectl logs -f deployment/quantum-defi-governance

# Delete deployment
kubectl delete -f k8s/
```

### Helm Chart

```bash
# Install monitoring
helm install monitoring ./charts/monitoring

# Install application
helm install quantum-defi-governance ./charts/app

# Uninstall
helm uninstall quantum-defi-governance
```

## 🔒 Security Setup

### Smart Contract Security

```bash
# Run Slither analysis
npm run security:slither

# Run Mythril analysis
npm run security:mythril

# Run security audit
npm run security:audit

# Generate security report
npm run security:report
```

### Frontend Security

```bash
# Run security audit
npm audit

# Check for vulnerabilities
npm audit fix

# Run security tests
npm run test:security
```

## 📊 Monitoring Setup

### Application Monitoring

```bash
# Setup monitoring
npm run monitoring:setup

# View metrics
npm run monitoring:dashboard

# Setup alerts
npm run monitoring:alerts
```

### Performance Monitoring

```bash
# Run performance tests
npm run test:performance

# View performance report
npm run performance:report

# Profile application
npm run profile
```

## 🧪 Testing

### Unit Tests

```bash
# Run all unit tests
npm run test:unit

# Run with coverage
npm run test:coverage

# Watch mode
npm run test:watch
```

### Integration Tests

```bash
# Run integration tests
npm run test:integration

# Run with specific suite
npm run test:integration -- --grep "Quantum"
```

### End-to-End Tests

```bash
# Run E2E tests
npm run test:e2e

# Run with specific browser
npm run test:e2e -- --project=chromium

# Run in headless mode
npm run test:e2e -- --headless
```

### Smart Contract Tests

```bash
# Run contract tests
forge test

# Run with coverage
forge coverage

# Run specific test
forge test --match-test testQuantumVoting

# Run gas report
forge test --gas-report
```

## 📚 Documentation

### Local Documentation

```bash
# Start documentation server
npm run docs:dev

# Build documentation
npm run docs:build

# Serve documentation
npm run docs:serve
```

### API Documentation

```bash
# Generate API docs
npm run docs:api

# View API docs
npm run docs:api:serve
```

## 🚀 Deployment

### Vercel Deployment

```bash
# Deploy to Vercel
npm run deploy:vercel

# Deploy to production
npm run deploy:vercel:prod

# View deployment
npm run deploy:vercel:view
```

### Cloudflare Workers

```bash
# Deploy to Cloudflare
npm run deploy:cf

# View deployment
npm run deploy:cf:view
```

### Custom Server

```bash
# Build for production
npm run build

# Start production server
npm run start

# Use PM2 for process management
pm2 start ecosystem.config.js
```

## 🔧 Development Tools

### Code Quality

```bash
# Run linting
npm run lint

# Fix linting issues
npm run lint:fix

# Run formatting
npm run format

# Check formatting
npm run format:check
```

### Pre-commit Hooks

```bash
# Install pre-commit hooks
npm run prepare

# Run pre-commit checks
npm run pre-commit

# Run all checks
npm run check:all
```

## 🐛 Troubleshooting

### Common Issues

1. **Node.js Version Mismatch**
   ```bash
   # Use correct Node.js version
   nvm use 18
   
   # Update package.json engines
   npm install
   ```

2. **Foundry Installation**
   ```bash
   # Install Foundry
   curl -L https://foundry.paradigm.xyz | bash
   foundryup
   
   # Verify installation
   forge --version
   ```

3. **WebAssembly Compilation**
   ```bash
   # Install Rust
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   
   # Install wasm-pack
   cargo install wasm-pack
   
   # Build WebAssembly
   npm run build:wasm
   ```

4. **Docker Issues**
   ```bash
   # Clear Docker cache
   docker system prune -a
   
   # Rebuild image
   docker build --no-cache -t quantum-defi-governance .
   ```

5. **Memory Issues**
   ```bash
   # Increase Node.js memory limit
   NODE_OPTIONS="--max-old-space-size=4096" npm run dev
   
   # Use swap file
   sudo fallocate -l 4G /swapfile
   sudo chmod 600 /swapfile
   sudo mkswap /swapfile
   sudo swapon /swapfile
   ```

### Debug Mode

```bash
# Enable debug logging
DEBUG=quantum-defi-governance:* npm run dev

# Enable verbose logging
VERBOSE=true npm run dev

# Enable performance profiling
PROFILE=true npm run dev
```

## 📞 Support

If you encounter any issues:

1. Check the [Issues](https://github.com/arturvojceh-ops/quantum-defi-governance/issues) page
2. Join our [Discord](https://discord.gg/quantum-defi) community
3. Contact us at [support@quantum-defi-governance.com](mailto:support@quantum-defi-governance.com)

## 🎯 Next Steps

Once you have the project set up:

1. Explore the [documentation](./docs/README.md)
2. Check out the [examples](./examples/README.md)
3. Read the [architecture guide](./docs/ARCHITECTURE.md)
4. Review the [security best practices](./docs/SECURITY.md)
5. Start building your quantum-enhanced DeFi governance solution!

---

**Happy coding! 🚀**
