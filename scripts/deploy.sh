#!/bin/bash
# Deploy ScreenContext landing page to Vercel

set -e

echo "🚀 Deploying ScreenContext landing page to Vercel..."
echo ""

cd "$(dirname "$0")/.."

# Check if Vercel CLI is installed
if ! command -v vercel &> /dev/null; then
    echo "📦 Installing Vercel CLI..."
    npm install -g vercel
fi

# Deploy
vercel --prod

echo ""
echo "✅ Deployment complete!"
echo ""
echo "📊 View waitlist signups:"
echo "   vercel logs screencontext"
echo ""
echo "🌐 Add custom domain:"
echo "   https://vercel.com/dashboard"
