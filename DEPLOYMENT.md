# Deployment Guide

## Quick Start (5 minutes)

### 1. Deploy to Vercel
```bash
cd ~/.openclaw/agents/screencontext-launch/landing-page
npx vercel
```

Answer prompts:
- **Set up and deploy?** Y
- **Scope:** (your account)
- **Link to project?** N
- **Project name:** screencontext
- **Directory:** ./
- **Override settings?** N

You'll get a URL like: `https://screencontext-abc123.vercel.app`

### 2. Add Custom Domain

In Vercel dashboard:
1. Go to project settings
2. Domains → Add Domain
3. Enter: `screencontext.app` (or your domain)
4. Update DNS records as instructed:
   - A Record: `@` → `76.76.21.21`
   - CNAME: `www` → `cname.vercel-dns.com`

DNS propagation takes 5-60 minutes.

### 3. View Waitlist Signups

**Option 1: Vercel Logs**
```bash
npx vercel logs screencontext --follow
```

**Option 2: Vercel Dashboard**
- Go to vercel.com/your-project
- Click "Logs" tab
- Filter for "waitlist"

Look for:
```
New waitlist signup: user@email.com 2026-02-02T14:22:00.000Z
```

### 4. Export Emails

To get a CSV of all emails:

```bash
npx vercel logs screencontext > logs.txt
grep "New waitlist signup" logs.txt | awk '{print $4}' > emails.csv
```

---

## Add Persistent Storage (When Ready)

### Option 1: Vercel KV (Simple Key-Value Store)

1. **Enable Vercel KV**
   ```bash
   npx vercel env add KV_REST_API_URL
   npx vercel env add KV_REST_API_TOKEN
   ```

2. **Update `api/waitlist.js`:**
   ```javascript
   import { kv } from '@vercel/kv';
   
   export default async function handler(req, res) {
     const { email } = req.body;
     
     // Save to KV
     await kv.sadd('waitlist', email);
     
     // Get count
     const count = await kv.scard('waitlist');
     
     return res.json({ success: true, count });
   }
   ```

3. **View all emails:**
   ```bash
   npx vercel kv smembers waitlist
   ```

### Option 2: Airtable (Spreadsheet-like)

1. Create Airtable base with "Email" column
2. Get API key from airtable.com/account
3. Add to Vercel env:
   ```bash
   npx vercel env add AIRTABLE_API_KEY
   npx vercel env add AIRTABLE_BASE_ID
   ```

4. Install Airtable SDK:
   ```bash
   npm install airtable
   ```

5. Update function to use Airtable

### Option 3: Google Sheets (Free, Easy)

1. Create Google Sheet
2. Use Sheets API or Zapier webhook
3. Point form to webhook URL

---

## Local Testing

```bash
# Install Vercel CLI
npm install -g vercel

# Run dev server
vercel dev
```

Visit `http://localhost:3000`

Test form submission, check terminal for logs.

---

## Production Checklist

Before launch:
- [ ] Custom domain added
- [ ] SSL certificate active (Vercel does this automatically)
- [ ] Form submission tested
- [ ] Email validation works
- [ ] Logs visible in dashboard
- [ ] OG image added (`og-image.jpg`)
- [ ] Favicon added
- [ ] Privacy policy reviewed
- [ ] Twitter/social cards tested (opengraph.xyz)

---

## Troubleshooting

**Form not submitting?**
- Check browser console for errors
- Verify `/api/waitlist` endpoint works: `curl -X POST https://your-site.com/api/waitlist -d '{"email":"test@test.com"}' -H "Content-Type: application/json"`

**No logs showing?**
- Wait 1-2 minutes for logs to appear
- Check you're looking at production logs (not preview)

**Domain not working?**
- Verify DNS records are correct
- Wait for DNS propagation (up to 24 hours, usually 5-60 min)
- Check domain is verified in Vercel dashboard

---

**Need help?** Check Vercel docs: vercel.com/docs
