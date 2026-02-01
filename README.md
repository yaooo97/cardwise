# CardWise - Smart Credit Card Assistant

A web application that helps credit card enthusiasts (churners) maximize their rewards by:
- Finding cards at their all-time high sign-up bonuses
- Recommending the best card to use for each purchase
- Tracking your card collection

## Tech Stack

- **Frontend**: Next.js 15 + React 19 + Tailwind CSS 4
- **Backend**: Supabase (PostgreSQL + Auth)
- **Deployment**: Vercel
- **Data Management**: Python crawler scripts

## Getting Started

### Prerequisites

- Node.js 18+
- npm
- A Supabase account (free tier works)

### 1. Clone and Install

```bash
npm install
```

### 2. Set Up Supabase

1. Create a new project at [supabase.com](https://supabase.com)
2. Go to Project Settings > API to get your credentials
3. Copy `.env.example` to `.env.local` and fill in your credentials:

```bash
cp .env.example .env.local
```

```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
```

### 3. Set Up Database

1. Go to your Supabase project's SQL Editor
2. Run the migration script from `supabase/migrations/001_initial_schema.sql`
3. Run the seed data script from `supabase/seed_data.sql`

### 4. Run Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

## Project Structure

```
├── app/                    # Next.js App Router pages
│   ├── (auth)/            # Auth pages (login, signup)
│   ├── dashboard/         # Protected dashboard pages
│   └── page.tsx           # Landing page
├── components/            # React components
│   ├── ui/               # Base UI components
│   ├── cards/            # Card-related components
│   ├── landing/          # Landing page sections
│   └── dashboard/        # Dashboard components
├── lib/                   # Utilities and configs
│   └── supabase/         # Supabase client setup
├── types/                 # TypeScript types
├── supabase/             # Database migrations and seeds
└── crawler/              # Python data management scripts
```

## Features

### My Cards
Select the credit cards you own to get personalized recommendations.

### Open a Card
Browse cards sorted by sign-up bonus value. Filter by:
- Issuer (Chase, Amex, Citi, etc.)
- All-time high bonuses only
- Cards you don't own yet

### Spending Guide
Select a spending category (dining, grocery, gas, etc.) to see which card in your collection gives the best rewards.

## Data Management

The `crawler/` directory contains Python scripts for maintaining card data:

```bash
cd crawler
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Check current data status
python crawler.py --check

# Export data to JSON
python crawler.py --export

# Update a card's SUB
python crawler.py --update --card "Chase Sapphire Preferred" --sub 75000 --highest
```

## Deployment

### Deploy to Vercel

1. Push your code to GitHub
2. Import the repository in [Vercel](https://vercel.com)
3. Add environment variables:
   - `NEXT_PUBLIC_SUPABASE_URL`
   - `NEXT_PUBLIC_SUPABASE_ANON_KEY`
4. Deploy!

### Supabase Configuration

Make sure to:
1. Enable Email Auth in Authentication > Providers
2. Configure your site URL in Authentication > URL Configuration
3. Add your Vercel domain to the allowed redirect URLs

## Cost

This project is designed to run within free tiers:
- **Vercel**: Free Hobby plan (100GB bandwidth/month)
- **Supabase**: Free plan (500MB database, 50K monthly active users)
- **Total**: $0/month (domain optional ~$10-15/year)

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

MIT

## Disclaimer

CardWise is a free tool for informational purposes only. We do not provide financial advice. Always do your own research before applying for credit cards.
