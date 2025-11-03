/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  swcMinify: true,
  // Increase body size limit to 500MB for large file uploads
  experimental: {
    serverActions: {
      bodySizeLimit: '500mb',
    },
  },
  async rewrites() {
    return [
      {
        source: '/api/upload',
        destination: 'https://file-sharing-website-estw.onrender.com/upload',
      },
      {
        source: '/api/download/:port',
        destination: 'https://file-sharing-website-estw.onrender.com/download/:port',
      },
    ];
  },
}

module.exports = nextConfig

