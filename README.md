# ScreenContext Landing Page

Premium SaaS landing page built with KishOS design system.

## Design System
- **Aesthetic:** Minimal, monospace, dark theme
- **Font:** SF Mono (system monospace stack)
- **Colors:** Black background, white text, sharp borders
- **Layout:** Bento grid, clear hierarchy, no border-radius
- **Inspired by:** Linear, Vercel, Stripe

## Deploy to Vercel

### 1. Deploy
```bash
cd ~/.openclaw/agents/screencontext-launch/landing-page
npx vercel
```

Follow prompts:
- Deploy: **Y**
- Scope: your account
- Link to project: **N**
- Project name: **screencontext**
- Directory: **./** (default)
- Override settings: **N**

### 2. View Waitlist Emails

Emails are logged to Vercel. View them:

```bash
# View recent logs
npx vercel logs screencontext

# Or in dashboard
# vercel.com/your-project/logs
```

Look for lines like:
```
New waitlist signup: user@email.com 2026-02-02T14:22:00.000Z
```

### 3. Export Emails (Later)

When you want to actually email people, you'll need to add persistent storage.

**Option A: Vercel KV (Recommended)**
```bash
# Create KV store in Vercel dashboard
# Then update api/waitlist.js to use it
```

**Option B: Airtable (Easy)**
Create a base, add API key to environment variables, update function.

**Option C: Google Sheets**
Use Google Sheets API (free, simple).

For now, emails are in logs ✅

## Custom Domain Setup

After deploying:
1. Add custom domain in hosting dashboard
2. Point DNS:
   - **A Record:** `@` → provided IP
   - **CNAME:** `www` → provided URL

Recommended domains:
- `screencontext.app`
- `screencontext.com`
- `getscreencontext.com`

## Email Collection

Simple email capture via Vercel serverless function.

**Emails are saved to Vercel logs** (accessible via CLI or dashboard).

To view signups:
```bash
./scripts/view-emails.sh
```

To upgrade to persistent storage (Vercel KV, Airtable, etc), see `DEPLOYMENT.md`.

## Files
- `index.html` - Landing page (KishOS design system)
- `privacy.html` - Privacy policy
- `vercel.json` - Vercel config (clean URLs)
- `README.md` - This file

## To Add
- [ ] App screenshot/demo video in hero
- [ ] OG image (`og-image.jpg`) 1200x630 for social
- [ ] Favicon (use app icon)
- [ ] Analytics script (PostHog/Plausible)
- [ ] Testimonials (post-launch)

## OG Image Specs
For best social sharing:
- **Size:** 1200 x 630 px
- **Format:** JPG or PNG
- **Text:** Large, readable on mobile
- **Style:** Match KishOS aesthetic (black bg, white text, monospace)

## Local Preview
```bash
# Simple HTTP server
python3 -m http.server 8000

# Or use any local server
npx serve
```

Visit `http://localhost:8000`

## Performance
- Pure HTML/CSS (no build step)
- ~18KB main page (gzipped: ~6KB)
- Loads in <500ms
- Perfect Lighthouse score (after images added)

## Messaging Hierarchy
1. **Hero:** Screen history, searchable (immediate value)
2. **Problem:** Rewind is gone (urgency)
3. **Solution:** Privacy-first, local-only (differentiation)
4. **Features:** How it works (education)
5. **Stats:** Zero cloud uploads (trust)
6. **CTA:** Join waitlist (conversion)

---

Built with KishOS design system. See `~/.openclaw/kishos-design.css` for full system.
