-- Credit Cards Table
CREATE TABLE credit_cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,
  issuer TEXT NOT NULL,
  annual_fee INTEGER NOT NULL DEFAULT 0, -- in cents
  current_sub INTEGER NOT NULL DEFAULT 0, -- in cents
  highest_sub INTEGER NOT NULL DEFAULT 0, -- in cents
  is_at_highest BOOLEAN DEFAULT false,
  sub_requirements TEXT,
  point_type TEXT,
  transfer_partners TEXT[],
  image_url TEXT,
  apply_url TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Card Rewards Table
CREATE TABLE card_rewards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  card_id UUID NOT NULL REFERENCES credit_cards(id) ON DELETE CASCADE,
  category TEXT NOT NULL,
  reward_rate DECIMAL(5,2) NOT NULL,
  reward_unit TEXT NOT NULL DEFAULT 'percent', -- 'percent' or 'points_per_dollar'
  cap_amount INTEGER, -- in cents, NULL means unlimited
  notes TEXT
);

-- User Cards Table
CREATE TABLE user_cards (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  card_id UUID NOT NULL REFERENCES credit_cards(id) ON DELETE CASCADE,
  acquired_date DATE,
  annual_fee_date DATE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, card_id)
);

-- Spending Categories Table
CREATE TABLE spending_categories (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  display_name TEXT NOT NULL,
  icon TEXT NOT NULL,
  description TEXT
);

-- Indexes for better performance
CREATE INDEX idx_credit_cards_issuer ON credit_cards(issuer);
CREATE INDEX idx_credit_cards_is_at_highest ON credit_cards(is_at_highest);
CREATE INDEX idx_card_rewards_card_id ON card_rewards(card_id);
CREATE INDEX idx_card_rewards_category ON card_rewards(category);
CREATE INDEX idx_user_cards_user_id ON user_cards(user_id);
CREATE INDEX idx_user_cards_card_id ON user_cards(card_id);

-- Row Level Security (RLS)
ALTER TABLE credit_cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE card_rewards ENABLE ROW LEVEL SECURITY;
ALTER TABLE user_cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE spending_categories ENABLE ROW LEVEL SECURITY;

-- Credit cards are readable by everyone
CREATE POLICY "Credit cards are viewable by everyone" ON credit_cards
  FOR SELECT USING (true);

-- Card rewards are readable by everyone
CREATE POLICY "Card rewards are viewable by everyone" ON card_rewards
  FOR SELECT USING (true);

-- Users can only see their own cards
CREATE POLICY "Users can view own cards" ON user_cards
  FOR SELECT USING (auth.uid() = user_id);

-- Users can insert their own cards
CREATE POLICY "Users can insert own cards" ON user_cards
  FOR INSERT WITH CHECK (auth.uid() = user_id);

-- Users can update their own cards
CREATE POLICY "Users can update own cards" ON user_cards
  FOR UPDATE USING (auth.uid() = user_id);

-- Users can delete their own cards
CREATE POLICY "Users can delete own cards" ON user_cards
  FOR DELETE USING (auth.uid() = user_id);

-- Spending categories are readable by everyone
CREATE POLICY "Spending categories are viewable by everyone" ON spending_categories
  FOR SELECT USING (true);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for credit_cards updated_at
CREATE TRIGGER update_credit_cards_updated_at
  BEFORE UPDATE ON credit_cards
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
