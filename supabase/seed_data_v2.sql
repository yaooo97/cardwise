-- Updated seed data with latest SUB info (Feb 2026)
-- Run this AFTER the initial migration if you want to update existing data
-- Or use this for fresh installs

-- First, add the new columns if they don't exist
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS sub_end_date DATE;
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS card_color TEXT DEFAULT '#1a1a2e';
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS card_color_end TEXT DEFAULT '#16213e';
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS description TEXT;

-- Clear existing data for fresh start (optional - comment out if you want to keep existing)
-- DELETE FROM card_rewards;
-- DELETE FROM user_cards;
-- DELETE FROM credit_cards;

-- Insert spending categories (if not exists)
INSERT INTO spending_categories (name, display_name, icon, description) VALUES
  ('dining', 'Dining', 'Utensils', 'Restaurants, cafes, bars, and food delivery'),
  ('grocery', 'Grocery', 'ShoppingCart', 'Supermarkets and grocery stores'),
  ('gas', 'Gas', 'Fuel', 'Gas stations and fuel'),
  ('travel', 'Travel', 'Plane', 'Airlines, hotels, car rentals'),
  ('streaming', 'Streaming', 'Tv', 'Netflix, Spotify, Disney+, etc.'),
  ('online_shopping', 'Online Shopping', 'ShoppingBag', 'Amazon, online retailers'),
  ('rent', 'Rent/Mortgage', 'Home', 'Rent and mortgage payments'),
  ('transit', 'Transit', 'Car', 'Public transit, Uber, Lyft'),
  ('business', 'Business', 'Briefcase', 'Office supplies, advertising'),
  ('other', 'Everything Else', 'MoreHorizontal', 'All other purchases')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- CHASE CARDS (Updated Feb 2026)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description) VALUES
  ('Chase Sapphire Preferred', 'Chase', 9500, 60000, 100000, false, 'Spend $4,000 in first 3 months', '2026-04-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott', 'IHG', 'British Airways'], '#004977', '#002244', 'Great starter travel card with 3x dining and 2x travel. Points worth 25% more on Chase travel portal.'),
  ('Chase Sapphire Reserve', 'Chase', 55000, 60000, 100000, false, 'Spend $4,000 in first 3 months', '2026-04-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott', 'IHG', 'British Airways'], '#1a1a2e', '#0d0d1a', 'Premium travel card with Priority Pass, $300 travel credit, 3x on travel and dining. Points worth 50% more on portal.'),
  ('Chase Freedom Unlimited', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#0066b2', '#004d86', 'No annual fee card earning 1.5% on everything, 3% dining, 3% drugstores, 5% travel booked through Chase.'),
  ('Chase Freedom Flex', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#0073cf', '#005299', '5% rotating categories (activate quarterly), 3% dining, 3% drugstores, plus cell phone protection.'),
  ('Chase Ink Business Preferred', 'Chase', 9500, 100000, 100000, true, 'Spend $8,000 in first 3 months', '2026-06-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#1c3a5f', '#0f2439', 'Best business card for SUB. 3x on shipping, travel, internet/cable/phone, advertising.'),
  ('Chase Ink Business Cash', 'Chase', 0, 75000, 90000, false, 'Spend $6,000 in first 3 months', '2026-03-31', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#004e7c', '#003654', '5% office supplies and internet/cable/phone (up to $25k), 2% gas and dining.'),
  ('Chase Ink Business Unlimited', 'Chase', 0, 75000, 90000, false, 'Spend $6,000 in first 3 months', '2026-03-31', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#005b8f', '#003d5f', 'Flat 1.5% unlimited cash back on all business purchases.'),
  ('World of Hyatt Credit Card', 'Chase', 9500, 60000, 60000, true, 'Spend $6,000 in first 6 months', NULL, 'World of Hyatt Points', ARRAY['Hyatt'], '#6b2d5b', '#4a1f3f', 'Best hotel card value. 4x at Hyatt, 2x dining/transit/gym. Free night up to Cat 4 annually.')
ON CONFLICT DO NOTHING;

-- ============================================
-- AMERICAN EXPRESS CARDS (Updated Feb 2026)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description) VALUES
  ('American Express Gold Card', 'Amex', 25000, 60000, 90000, false, 'Spend $6,000 in first 6 months', '2026-05-01', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore', 'Air France', 'British Airways'], '#b8860b', '#8b6914', 'Best dining card with 4x restaurants worldwide and 4x US supermarkets (up to $25k). $120 dining credit + $120 Uber credit.'),
  ('American Express Platinum Card', 'Amex', 69500, 80000, 150000, false, 'Spend $8,000 in first 6 months', '2026-05-01', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore', 'Air France', 'British Airways'], '#e5e4e2', '#c0c0c0', 'Premium travel card with Centurion Lounge access, $200 airline credit, $200 hotel credit, $189 CLEAR, and more.'),
  ('Blue Cash Preferred', 'Amex', 0, 25000, 40000, false, 'Spend $3,000 in first 6 months', NULL, 'Cash Back', NULL, '#0077c8', '#005a99', '6% at US supermarkets (up to $6k/year), 6% streaming, 3% transit, 3% gas.'),
  ('Blue Cash Everyday', 'Amex', 0, 20000, 25000, false, 'Spend $2,000 in first 6 months', NULL, 'Cash Back', NULL, '#00aaff', '#0088cc', '3% at US supermarkets (up to $6k/year), 3% US gas stations, 3% US online retail.'),
  ('Delta SkyMiles Gold', 'Amex', 0, 70000, 70000, true, 'Spend $2,000 in first 6 months', '2026-04-15', 'Delta Miles', ARRAY['Delta'], '#86754f', '#6b5d3f', 'No annual fee Delta card with 2x Delta purchases, restaurants, and supermarkets.'),
  ('Delta SkyMiles Platinum', 'Amex', 35000, 90000, 90000, true, 'Spend $4,000 in first 6 months', '2026-04-15', 'Delta Miles', ARRAY['Delta'], '#3d4f5f', '#2d3a47', 'Premium Delta card with companion certificate, free checked bag, 3x Delta and hotels.'),
  ('Hilton Honors American Express Card', 'Amex', 0, 80000, 100000, false, 'Spend $2,000 in first 6 months', NULL, 'Hilton Points', ARRAY['Hilton'], '#104c8b', '#0a3662', 'No annual fee Hilton card with 7x Hilton, 5x dining/gas/grocery, automatic Silver status.'),
  ('Hilton Honors Surpass Card', 'Amex', 15000, 130000, 150000, false, 'Spend $3,000 in first 6 months', NULL, 'Hilton Points', ARRAY['Hilton'], '#1a5e9e', '#124578', '12x Hilton, 6x dining/gas/grocery, automatic Gold status, free night after $15k spend.')
ON CONFLICT DO NOTHING;

-- ============================================
-- CAPITAL ONE CARDS (Updated Feb 2026)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description) VALUES
  ('Capital One Venture X', 'Capital One', 39500, 75000, 100000, false, 'Spend $4,000 in first 3 months', '2026-03-31', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates', 'Singapore', 'Avianca', 'TAP', 'Finnair'], '#1a1a2e', '#0d0d1a', 'Premium travel card with 10x hotels/cars via portal, lounge access, $300 travel credit, 10k anniversary bonus.'),
  ('Capital One Venture', 'Capital One', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', '2026-04-30', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates'], '#c41230', '#8b0000', 'Solid 2x everywhere card with transfer partners. Easy to earn and redeem.'),
  ('Capital One Savor', 'Capital One', 9500, 30000, 30000, true, 'Spend $3,000 in first 3 months', NULL, 'Cash Back', NULL, '#b22234', '#8b1a28', '4% dining and entertainment, 4% streaming, 3% grocery, 1% everything else.'),
  ('Capital One SavorOne', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Cash Back', NULL, '#cc2936', '#a11f2b', 'No AF version: 3% dining and entertainment, 3% streaming, 3% grocery, 1% everything else.'),
  ('Capital One Quicksilver', 'Capital One', 0, 20000, 20000, true, 'One-time $200 after $500 spend', NULL, 'Cash Back', NULL, '#4a4a4a', '#333333', 'Simple 1.5% unlimited cash back on everything. No categories to track.')
ON CONFLICT DO NOTHING;

-- ============================================
-- CITI CARDS (Updated Feb 2026)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description) VALUES
  ('Citi Strata Premier', 'Citi', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', '2026-05-15', 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'Virgin Atlantic', 'JetBlue', 'Avianca', 'Air France', 'Emirates', 'Etihad', 'Qatar'], '#003b70', '#002244', 'Citi''s new premium card: 3x travel/gas/groceries/dining, 1x everything else. Great transfer partners.'),
  ('Citi Double Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', NULL, 'Cash Back / ThankYou Points', NULL, '#1a4480', '#0e2d54', 'Effective 2% on everything (1% when you buy, 1% when you pay). Can convert to TYP.'),
  ('Citi Custom Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', NULL, 'Cash Back / ThankYou Points', NULL, '#2e5c8a', '#1a3d5c', 'Auto 5% in your top spend category each month (up to $500). Great flexible card.')
ON CONFLICT DO NOTHING;

-- ============================================
-- OTHER ISSUERS (Updated Feb 2026)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description) VALUES
  ('Wells Fargo Autograph', 'Wells Fargo', 0, 20000, 30000, false, 'Spend $1,500 in first 3 months', NULL, 'Points', NULL, '#d71e28', '#a3161d', 'No AF card with 3x restaurants, travel, gas, transit, streaming, phone plans.'),
  ('Wells Fargo Active Cash', 'Wells Fargo', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Cash Back', NULL, '#cd1309', '#a30f07', 'Simple 2% unlimited cash back on everything. No categories to track.'),
  ('Discover it Cash Back', 'Discover', 0, 0, 0, true, 'No SUB - Cashback Match first year', NULL, 'Cash Back', NULL, '#ff6600', '#cc5200', '5% rotating categories (activate quarterly), 1% everything else. All cash back MATCHED first year = 10%/2%!'),
  ('US Bank Altitude Go', 'US Bank', 0, 25000, 25000, true, 'Spend $1,000 in first 90 days', NULL, 'Altitude Points', NULL, '#0033a0', '#002266', '4x dining and takeout, 2x groceries/gas/streaming, no AF. Great companion card.'),
  ('Bank of America Customized Cash', 'Bank of America', 0, 20000, 20000, true, 'Spend $1,000 in first 90 days', NULL, 'Cash Back', NULL, '#e31837', '#b3001b', '3% in category of choice (gas, online shopping, dining, travel, drug stores, home improvement), 2% grocery/wholesale.')
ON CONFLICT DO NOTHING;

-- ============================================
-- UPDATED CARD REWARDS
-- ============================================

-- Chase Sapphire Preferred rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants and eligible delivery services' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'streaming', 3, 'points_per_dollar', NULL, 'Select streaming services' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'online_shopping', 3, 'points_per_dollar', NULL, 'Online grocery and Instacart' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'travel', 2, 'points_per_dollar', NULL, 'All travel purchases' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;

-- Amex Gold rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'dining', 4, 'points_per_dollar', NULL, 'Restaurants worldwide including takeout' FROM credit_cards WHERE name = 'American Express Gold Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'grocery', 4, 'points_per_dollar', 2500000, 'US supermarkets up to $25,000/year' FROM credit_cards WHERE name = 'American Express Gold Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'travel', 3, 'points_per_dollar', NULL, 'Flights booked with airlines or Amex Travel' FROM credit_cards WHERE name = 'American Express Gold Card' ON CONFLICT DO NOTHING;

-- Citi Strata Premier rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'travel', 3, 'points_per_dollar', NULL, 'Air travel and hotels' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'grocery', 3, 'points_per_dollar', NULL, 'Supermarkets' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'gas', 3, 'points_per_dollar', NULL, 'Gas stations' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;

-- Capital One Venture X rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'travel', 10, 'points_per_dollar', NULL, 'Hotels and rental cars through Capital One Travel' FROM credit_cards WHERE name = 'Capital One Venture X' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'other', 2, 'points_per_dollar', NULL, 'All other purchases' FROM credit_cards WHERE name = 'Capital One Venture X' ON CONFLICT DO NOTHING;

-- Blue Cash Preferred rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'grocery', 6, 'percent', 600000, 'US supermarkets up to $6,000/year' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'streaming', 6, 'percent', NULL, 'Select streaming subscriptions' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'transit', 3, 'percent', NULL, 'Transit including Uber, Lyft, parking' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'gas', 3, 'percent', NULL, 'US gas stations' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;

-- Wells Fargo Autograph rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants' FROM credit_cards WHERE name = 'Wells Fargo Autograph' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'travel', 3, 'points_per_dollar', NULL, 'Travel purchases' FROM credit_cards WHERE name = 'Wells Fargo Autograph' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'gas', 3, 'points_per_dollar', NULL, 'Gas stations' FROM credit_cards WHERE name = 'Wells Fargo Autograph' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'transit', 3, 'points_per_dollar', NULL, 'Transit and rideshare' FROM credit_cards WHERE name = 'Wells Fargo Autograph' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'streaming', 3, 'points_per_dollar', NULL, 'Streaming services' FROM credit_cards WHERE name = 'Wells Fargo Autograph' ON CONFLICT DO NOTHING;

-- Flat rate cards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'other', 2, 'percent', NULL, 'Unlimited 2% on all purchases' FROM credit_cards WHERE name = 'Citi Double Cash Card' ON CONFLICT DO NOTHING;

INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'other', 2, 'percent', NULL, 'Unlimited 2% on all purchases' FROM credit_cards WHERE name = 'Wells Fargo Active Cash' ON CONFLICT DO NOTHING;

INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'other', 1.5, 'percent', NULL, 'Unlimited 1.5% on all purchases' FROM credit_cards WHERE name = 'Chase Freedom Unlimited' ON CONFLICT DO NOTHING;

INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes)
SELECT id, 'other', 1.5, 'percent', NULL, 'Unlimited 1.5% on all purchases' FROM credit_cards WHERE name = 'Capital One Quicksilver' ON CONFLICT DO NOTHING;
