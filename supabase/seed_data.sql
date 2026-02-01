-- Seed data for credit cards and rewards
-- Run this in your Supabase SQL editor after creating the tables

-- Insert spending categories
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
  ('other', 'Everything Else', 'MoreHorizontal', 'All other purchases');

-- ============================================
-- CHASE CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Chase Sapphire Preferred', 'Chase', 9500, 60000, 100000, false, 'Spend $4,000 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Sapphire Reserve', 'Chase', 55000, 60000, 100000, false, 'Spend $4,000 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Freedom Unlimited', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Freedom Flex', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Ink Business Preferred', 'Chase', 9500, 100000, 100000, true, 'Spend $8,000 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Ink Business Cash', 'Chase', 0, 90000, 90000, true, 'Spend $6,000 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('Chase Ink Business Unlimited', 'Chase', 0, 90000, 90000, true, 'Spend $6,000 in first 3 months', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott']),
  ('United Explorer Card', 'Chase', 9500, 60000, 70000, false, 'Spend $3,000 in first 3 months', 'United Miles', ARRAY['United']),
  ('Southwest Rapid Rewards Priority', 'Chase', 14900, 50000, 75000, false, 'Spend $3,000 in first 3 months', 'Southwest Points', ARRAY['Southwest']),
  ('IHG One Rewards Premier', 'Chase', 9900, 140000, 175000, false, 'Spend $3,000 in first 3 months', 'IHG Points', ARRAY['IHG']),
  ('World of Hyatt Credit Card', 'Chase', 9500, 60000, 60000, true, 'Spend $6,000 in first 6 months', 'World of Hyatt Points', ARRAY['Hyatt']),
  ('Marriott Bonvoy Boundless', 'Chase', 9500, 85000, 125000, false, 'Spend $3,000 in first 3 months', 'Marriott Points', ARRAY['Marriott']);

-- ============================================
-- AMERICAN EXPRESS CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('American Express Gold Card', 'Amex', 25000, 60000, 90000, false, 'Spend $6,000 in first 6 months', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore']),
  ('American Express Platinum Card', 'Amex', 69500, 80000, 150000, false, 'Spend $8,000 in first 6 months', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore']),
  ('Blue Cash Preferred', 'Amex', 9500, 35000, 40000, false, 'Spend $3,000 in first 6 months', 'Cash Back', NULL),
  ('Blue Cash Everyday', 'Amex', 0, 20000, 25000, false, 'Spend $2,000 in first 6 months', 'Cash Back', NULL),
  ('Amex EveryDay Preferred', 'Amex', 9500, 15000, 25000, false, 'Spend $2,000 in first 6 months', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore']),
  ('Delta SkyMiles Gold', 'Amex', 0, 70000, 70000, true, 'Spend $2,000 in first 6 months', 'Delta Miles', ARRAY['Delta']),
  ('Delta SkyMiles Platinum', 'Amex', 35000, 90000, 90000, true, 'Spend $4,000 in first 6 months', 'Delta Miles', ARRAY['Delta']),
  ('Delta SkyMiles Reserve', 'Amex', 65000, 80000, 125000, false, 'Spend $6,000 in first 6 months', 'Delta Miles', ARRAY['Delta']),
  ('Hilton Honors American Express Card', 'Amex', 0, 100000, 100000, true, 'Spend $2,000 in first 6 months', 'Hilton Points', ARRAY['Hilton']),
  ('Hilton Honors Surpass Card', 'Amex', 15000, 150000, 150000, true, 'Spend $3,000 in first 6 months', 'Hilton Points', ARRAY['Hilton']),
  ('Hilton Honors Aspire Card', 'Amex', 45000, 175000, 175000, true, 'Spend $4,000 in first 6 months', 'Hilton Points', ARRAY['Hilton']),
  ('Marriott Bonvoy Brilliant', 'Amex', 65000, 95000, 150000, false, 'Spend $6,000 in first 6 months', 'Marriott Points', ARRAY['Marriott']),
  ('Amex Business Gold', 'Amex', 37500, 70000, 100000, false, 'Spend $10,000 in first 3 months', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore']),
  ('Amex Business Platinum', 'Amex', 69500, 120000, 170000, false, 'Spend $15,000 in first 3 months', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore']);

-- ============================================
-- CITI CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Citi Premier Card', 'Citi', 9500, 60000, 80000, false, 'Spend $4,000 in first 3 months', 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'Virgin Atlantic', 'JetBlue']),
  ('Citi Double Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', 'Cash Back / ThankYou Points', NULL),
  ('Citi Custom Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', 'Cash Back / ThankYou Points', NULL),
  ('Citi Strata Premier', 'Citi', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'Virgin Atlantic', 'JetBlue']),
  ('Citi AAdvantage Platinum Select', 'Citi', 9900, 50000, 75000, false, 'Spend $2,500 in first 3 months', 'AAdvantage Miles', ARRAY['American Airlines']),
  ('Citi AAdvantage Executive', 'Citi', 59500, 70000, 100000, false, 'Spend $7,000 in first 3 months', 'AAdvantage Miles', ARRAY['American Airlines']);

-- ============================================
-- CAPITAL ONE CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Capital One Venture X', 'Capital One', 39500, 75000, 100000, false, 'Spend $4,000 in first 3 months', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates']),
  ('Capital One Venture', 'Capital One', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates']),
  ('Capital One VentureOne', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Capital One Miles', NULL),
  ('Capital One Savor', 'Capital One', 9500, 30000, 30000, true, 'Spend $3,000 in first 3 months', 'Cash Back', NULL),
  ('Capital One SavorOne', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Cash Back', NULL),
  ('Capital One Quicksilver', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Cash Back', NULL),
  ('Capital One Spark Cash Plus', 'Capital One', 15000, 50000, 100000, false, 'Spend $5,000 in first 3 months', 'Cash Back', NULL);

-- ============================================
-- BANK OF AMERICA CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Bank of America Premium Rewards', 'Bank of America', 9500, 60000, 75000, false, 'Spend $4,000 in first 90 days', 'Cash Back', NULL),
  ('Bank of America Customized Cash Rewards', 'Bank of America', 0, 20000, 20000, true, 'Spend $1,000 in first 90 days', 'Cash Back', NULL),
  ('Bank of America Unlimited Cash Rewards', 'Bank of America', 0, 20000, 20000, true, 'Spend $1,000 in first 90 days', 'Cash Back', NULL),
  ('Bank of America Travel Rewards', 'Bank of America', 0, 25000, 25000, true, 'Spend $1,000 in first 90 days', 'Travel Points', NULL),
  ('Alaska Airlines Visa Signature', 'Bank of America', 9500, 70000, 70000, true, 'Spend $3,000 in first 90 days', 'Alaska Miles', ARRAY['Alaska Airlines']);

-- ============================================
-- US BANK CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('US Bank Altitude Reserve', 'US Bank', 40000, 50000, 75000, false, 'Spend $4,500 in first 90 days', 'Altitude Points', NULL),
  ('US Bank Altitude Go', 'US Bank', 0, 25000, 25000, true, 'Spend $1,000 in first 90 days', 'Altitude Points', NULL),
  ('US Bank Altitude Connect', 'US Bank', 9500, 50000, 60000, false, 'Spend $2,500 in first 120 days', 'Altitude Points', NULL),
  ('US Bank Cash+', 'US Bank', 0, 20000, 20000, true, 'Spend $1,000 in first 120 days', 'Cash Back', NULL);

-- ============================================
-- WELLS FARGO CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Wells Fargo Autograph', 'Wells Fargo', 0, 30000, 30000, true, 'Spend $1,500 in first 3 months', 'Points', NULL),
  ('Wells Fargo Active Cash', 'Wells Fargo', 0, 20000, 20000, true, 'Spend $500 in first 3 months', 'Cash Back', NULL),
  ('Wells Fargo Autograph Journey', 'Wells Fargo', 9500, 60000, 60000, true, 'Spend $4,000 in first 3 months', 'Points', NULL);

-- ============================================
-- DISCOVER CARDS
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, point_type, transfer_partners) VALUES
  ('Discover it Cash Back', 'Discover', 0, 15000, 15000, true, 'No spending requirement - Cashback Match', 'Cash Back', NULL),
  ('Discover it Miles', 'Discover', 0, 15000, 15000, true, 'No spending requirement - Miles Match', 'Miles', NULL);

-- ============================================
-- CARD REWARDS (Category Bonuses)
-- ============================================

-- Chase Sapphire Preferred
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Sapphire Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 2, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Sapphire Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Sapphire Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'online_shopping', 3, 'points_per_dollar', NULL, 'Eligible delivery services' FROM credit_cards WHERE name = 'Chase Sapphire Preferred';

-- Chase Sapphire Reserve
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Sapphire Reserve';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Sapphire Reserve';

-- Chase Freedom Flex
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Freedom Flex';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'transit', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Freedom Flex';

-- Chase Freedom Unlimited
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Freedom Unlimited';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'transit', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Chase Freedom Unlimited';

-- American Express Gold Card
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 4, 'points_per_dollar', NULL, 'Worldwide restaurants' FROM credit_cards WHERE name = 'American Express Gold Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 4, 'points_per_dollar', 2500000, 'Up to $25,000/year at US supermarkets' FROM credit_cards WHERE name = 'American Express Gold Card';

-- American Express Platinum Card
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 5, 'points_per_dollar', NULL, 'Flights booked directly with airlines' FROM credit_cards WHERE name = 'American Express Platinum Card';

-- Blue Cash Preferred
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 6, 'percent', 600000, 'Up to $6,000/year at US supermarkets' FROM credit_cards WHERE name = 'Blue Cash Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 6, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Blue Cash Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'transit', 3, 'percent', NULL, 'Including Uber, Lyft, taxis' FROM credit_cards WHERE name = 'Blue Cash Preferred';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 3, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Blue Cash Preferred';

-- Capital One Savor
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 4, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One Savor';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 4, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One Savor';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 3, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One Savor';

-- Capital One SavorOne
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One SavorOne';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 3, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One SavorOne';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 3, 'percent', NULL, NULL FROM credit_cards WHERE name = 'Capital One SavorOne';

-- Capital One Venture X
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 10, 'points_per_dollar', NULL, 'Hotels and rental cars through Capital One Travel' FROM credit_cards WHERE name = 'Capital One Venture X';

-- Citi Premier
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Citi Premier Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Citi Premier Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 3, 'points_per_dollar', NULL, 'Air travel and hotels' FROM credit_cards WHERE name = 'Citi Premier Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Citi Premier Card';

-- Citi Double Cash
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'other', 2, 'percent', NULL, '1% when you buy + 1% when you pay' FROM credit_cards WHERE name = 'Citi Double Cash Card';

-- Citi Custom Cash
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 5, 'percent', 50000, 'Top eligible spend category each billing cycle, up to $500' FROM credit_cards WHERE name = 'Citi Custom Cash Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 5, 'percent', 50000, 'Top eligible spend category each billing cycle, up to $500' FROM credit_cards WHERE name = 'Citi Custom Cash Card';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 5, 'percent', 50000, 'Top eligible spend category each billing cycle, up to $500' FROM credit_cards WHERE name = 'Citi Custom Cash Card';

-- Wells Fargo Autograph
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Wells Fargo Autograph';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'travel', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Wells Fargo Autograph';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Wells Fargo Autograph';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'transit', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Wells Fargo Autograph';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 3, 'points_per_dollar', NULL, NULL FROM credit_cards WHERE name = 'Wells Fargo Autograph';

-- Wells Fargo Active Cash
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'other', 2, 'percent', NULL, 'Flat 2% on everything' FROM credit_cards WHERE name = 'Wells Fargo Active Cash';

-- Discover it Cash Back (5% rotating categories)
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 5, 'percent', 150000, 'Quarterly rotating categories, up to $1,500' FROM credit_cards WHERE name = 'Discover it Cash Back';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 5, 'percent', 150000, 'Quarterly rotating categories, up to $1,500' FROM credit_cards WHERE name = 'Discover it Cash Back';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 5, 'percent', 150000, 'Quarterly rotating categories, up to $1,500' FROM credit_cards WHERE name = 'Discover it Cash Back';

-- US Bank Cash+
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'streaming', 5, 'percent', 200000, 'Choose 2 categories for 5%, up to $2,000 combined' FROM credit_cards WHERE name = 'US Bank Cash+';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 5, 'percent', 200000, 'Choose 2 categories for 5%, up to $2,000 combined' FROM credit_cards WHERE name = 'US Bank Cash+';

-- Bank of America Customized Cash Rewards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'dining', 3, 'percent', 250000, 'Choose your 3% category, up to $2,500/quarter' FROM credit_cards WHERE name = 'Bank of America Customized Cash Rewards';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'grocery', 3, 'percent', 250000, 'Choose your 3% category, up to $2,500/quarter' FROM credit_cards WHERE name = 'Bank of America Customized Cash Rewards';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'gas', 3, 'percent', 250000, 'Choose your 3% category, up to $2,500/quarter' FROM credit_cards WHERE name = 'Bank of America Customized Cash Rewards';
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) 
SELECT id, 'online_shopping', 3, 'percent', 250000, 'Choose your 3% category, up to $2,500/quarter' FROM credit_cards WHERE name = 'Bank of America Customized Cash Rewards';
