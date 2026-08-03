/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  
  experimental: {
    appDir: true,
    serverComponentsExternalPackages: ['@prisma/client'],
    optimizeCss: true,
    optimizePackageImports: ['lucide-react', 'recharts', 'three'],
    scrollRestoration: true,
    largePageDataBytes: 128 * 1000,
  },
  
  images: {
    domains: [
      'localhost',
      'vercel.app',
      'cloudflare-ipfs.com',
      'ipfs.io',
      'gateway.pinata.cloud',
      'arweave.net',
    ],
    formats: ['image/webp', 'image/avif'],
    deviceSizes: [640, 750, 828, 1080, 1200, 1920, 2048, 3840],
    imageSizes: [16, 32, 48, 64, 96, 128, 256, 384],
  },
  
  env: {
    NEXT_PUBLIC_APP_NAME: 'Quantum DeFi Governance',
    NEXT_PUBLIC_APP_VERSION: process.env.npm_package_version,
    NEXT_PUBLIC_CHAIN_ID: process.env.NEXT_PUBLIC_CHAIN_ID || '1',
    NEXT_PUBLIC_RPC_URL: process.env.NEXT_PUBLIC_RPC_URL,
    NEXT_PUBLIC_WSS_URL: process.env.NEXT_PUBLIC_WSS_URL,
    NEXT_PUBLIC_INFURA_ID: process.env.NEXT_PUBLIC_INFURA_ID,
    NEXT_PUBLIC_ETHERSCAN_API_KEY: process.env.NEXT_PUBLIC_ETHERSCAN_API_KEY,
    NEXT_PUBLIC_PINATA_API_KEY: process.env.NEXT_PUBLIC_PINATA_API_KEY,
    NEXT_PUBLIC_PINATA_SECRET: process.env.NEXT_PUBLIC_PINATA_SECRET,
    NEXT_PUBLIC_ARWEAVE_KEY: process.env.NEXT_PUBLIC_ARWEAVE_KEY,
    NEXT_PUBLIC_QUANTUM_API_URL: process.env.NEXT_PUBLIC_QUANTUM_API_URL,
    NEXT_PUBLIC_SECURE_ENCLAVE_URL: process.env.NEXT_PUBLIC_SECURE_ENCLAVE_URL,
    NEXT_PUBLIC_ANALYTICS_ID: process.env.NEXT_PUBLIC_ANALYTICS_ID,
    NEXT_PUBLIC_SENTRY_DSN: process.env.NEXT_PUBLIC_SENTRY_DSN,
  },
  
  webpack: (config, { dev, isServer }) => {
    config.experiments = {
      ...config.experiments,
      asyncWebAssembly: true,
      layers: true,
    };

    config.resolve.extensions.push('.wasm');

    config.module.rules.push({
      test: /\.wasm$/,
      type: 'webassembly/async',
    });

    config.resolve.alias = {
      ...config.resolve.alias,
      three: 'three',
    };

    if (!dev && !isServer) {
      config.optimization = {
        ...config.optimization,
        splitChunks: {
          chunks: 'all',
          cacheGroups: {
            default: {
              minChunks: 2,
              priority: -20,
              reuseExistingChunk: true,
            },
            vendor: {
              test: /[\\/]node_modules[\\/]/,
              name: 'vendors',
              priority: -10,
              chunks: 'all',
            },
            three: {
              test: /[\\/]node_modules[\\/]three[\\/]/,
              name: 'three',
              priority: -5,
              chunks: 'all',
            },
            react: {
              test: /[\\/]node_modules[\\/](react|react-dom)[\\/]/,
              name: 'react',
              priority: 0,
              chunks: 'all',
            },
          },
        },
      };
    }
    
    return config;
  },
  
  async redirects() {
    return [
      {
        source: '/github',
        destination: 'https://github.com/arturvojceh-ops/quantum-defi-governance',
        permanent: false,
      },
      {
        source: '/docs',
        destination: 'https://docs.quantum-defi-governance.com',
        permanent: false,
      },
      {
        source: '/discord',
        destination: 'https://discord.gg/quantum-defi',
        permanent: false,
      },
    ];
  },
  
  async rewrites() {
    return [
      {
        source: '/api/quantum/:path*',
        destination: `${process.env.NEXT_PUBLIC_QUANTUM_API_URL}/:path*`,
      },
      {
        source: '/api/secure-enclave/:path*',
        destination: `${process.env.NEXT_PUBLIC_SECURE_ENCLAVE_URL}/:path*`,
      },
    ];
  },
  
  async headers() {
    return [
      {
        source: '/api/:path*',
        headers: [
          {
            key: 'Cache-Control',
            value: 'no-store, must-revalidate',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-XSS-Protection',
            value: '1; mode=block',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
          {
            key: 'Content-Security-Policy',
            value: "default-src 'self'; script-src 'self' 'unsafe-eval' 'unsafe-inline'; style-src 'self' 'unsafe-inline'; img-src 'self' data: https:; font-src 'self' data:; connect-src 'self' https: wss:; media-src 'self' https:; object-src 'none'; base-uri 'self'; form-action 'self'; frame-ancestors 'none';",
          },
        ],
      },
      {
        source: '/_next/static/(.*)',
        headers: [
          {
            key: 'Cache-Control',
            value: 'public, max-age=31536000, immutable',
          },
        ],
      },
      {
        source: '/(.*)',
        headers: [
          {
            key: 'X-Frame-Options',
            value: 'DENY',
          },
          {
            key: 'X-Content-Type-Options',
            value: 'nosniff',
          },
          {
            key: 'Referrer-Policy',
            value: 'strict-origin-when-cross-origin',
          },
        ],
      },
    ];
  },
  
  output: 'standalone',
  distDir: 'dist',
  poweredByHeader: false,
  generateEtags: true,
  generateBuildId: async () => {
    return `quantum-defi-governance-${Date.now()}`;
  },
  compress: true,
  httpAgentOptions: {
    keepAlive: true,
  },
  assetPrefix: process.env.NODE_ENV === 'production' ? 'https://cdn.quantum-defi-governance.com' : undefined,
  basePath: process.env.NODE_ENV === 'production' ? '/app' : undefined,
  trailingSlash: false,
  i18n: {
    locales: ['en', 'zh', 'ja', 'ko', 'es', 'fr', 'de', 'ru'],
    defaultLocale: 'en',
    localeDetection: true,
  },
  typescript: {
    ignoreBuildErrors: false,
    tsconfigPath: './tsconfig.json',
  },
  eslint: {
    ignoreDuringBuilds: false,
    dirs: ['app', 'components', 'lib', 'utils', 'hooks', 'types'],
  },
  bundleAnalyzer: {
    enabled: process.env.ANALYZE === 'true',
  },
  logging: {
    fetches: {
      fullUrl: false,
    },
  },
};

module.exports = nextConfig;
