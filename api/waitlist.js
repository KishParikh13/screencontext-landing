// Vercel Serverless Function - Email Capture
// Saves emails to Vercel KV (simple key-value store)

export default async function handler(req, res) {
  // Only allow POST
  if (req.method !== 'POST') {
    return res.status(405).json({ error: 'Method not allowed' });
  }

  try {
    const { email } = req.body;

    // Validate email
    if (!email || !email.includes('@')) {
      return res.status(400).json({ error: 'Invalid email' });
    }

    // Normalize email
    const normalizedEmail = email.toLowerCase().trim();

    // For now, just log it (you'll add storage later)
    console.log('New waitlist signup:', normalizedEmail, new Date().toISOString());

    // TODO: Add to database (Vercel KV, Postgres, or Airtable)
    // For v1, emails will be in Vercel logs (accessible via `vercel logs`)

    // Send success response
    return res.status(200).json({ 
      success: true, 
      message: 'Added to waitlist!' 
    });

  } catch (error) {
    console.error('Waitlist error:', error);
    return res.status(500).json({ error: 'Something went wrong' });
  }
}
