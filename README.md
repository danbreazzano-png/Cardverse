# CARDVERSE V1 — functional app starter

This is a real Next.js + Supabase application scaffold, not just a static mockup.

## What works
- Responsive landing page
- Supabase email/password sign-up and login
- Auth-protected collector dashboard
- Persistent card collection in Postgres
- Card Passport IDs
- Deal Score field
- Demo card scan flow
- Collection and Passport views
- Row-level security policies
- Private card-image storage bucket ready for production

## Setup
1. Create a Supabase project.
2. Open Supabase SQL Editor and run `supabase/schema.sql`.
3. Copy `.env.example` to `.env.local`.
4. Put your Supabase Project URL and anon/public key in `.env.local`.
5. Run:
   npm install
   npm run dev
6. Open http://localhost:3000

## Production scanner
The UI intentionally separates the scan workflow from the AI provider. For a production scanner, connect a vision API/server route and return structured JSON:
name, set, year, card_number, sport_or_game, grade/condition estimate, and confidence.

Do NOT put secret AI/API keys in NEXT_PUBLIC_* variables. Keep them server-side.

## Valuation data
The demo values are not live market data. For production, use licensed/permitted market data and record source/timestamp for every valuation.

## Security
Never paste your Supabase service-role key into the browser. Only the anon/public key belongs in NEXT_PUBLIC_SUPABASE_ANON_KEY.
