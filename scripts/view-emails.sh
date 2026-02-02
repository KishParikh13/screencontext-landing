#!/bin/bash
# View waitlist signups from Vercel logs

set -e

echo "📧 Fetching waitlist signups from Vercel logs..."
echo ""

cd "$(dirname "$0")/.."

# Get logs and extract emails
vercel logs screencontext --limit=1000 | \
  grep "New waitlist signup" | \
  awk '{print $4, $5}' | \
  sort -u

echo ""
echo "💡 To export to CSV:"
echo "   ./scripts/view-emails.sh > emails.csv"
