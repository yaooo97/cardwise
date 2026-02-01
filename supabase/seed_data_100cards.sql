-- Expanded seed data with 100+ credit cards (Feb 2026)
-- Run this in Supabase SQL Editor

-- First, add new columns if they don't exist
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS sub_end_date DATE;
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS card_color TEXT DEFAULT '#1a1a2e';
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS card_color_end TEXT DEFAULT '#16213e';
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS description TEXT;
ALTER TABLE credit_cards ADD COLUMN IF NOT EXISTS official_url TEXT;

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
  ('other', 'Everything Else', 'MoreHorizontal', 'All other purchases')
ON CONFLICT (name) DO NOTHING;

-- ============================================
-- CHASE CARDS (15 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Chase Sapphire Preferred', 'Chase', 9500, 60000, 100000, false, 'Spend $4,000 in first 3 months', '2026-04-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott', 'IHG', 'British Airways', 'Air France', 'Virgin Atlantic'], '#004977', '#002244', '3x dining/streaming, 2x travel. Points worth 25% more on Chase portal. Great starter travel card.', 'https://creditcards.chase.com/rewards-credit-cards/sapphire/preferred'),
  ('Chase Sapphire Reserve', 'Chase', 55000, 60000, 100000, false, 'Spend $4,000 in first 3 months', '2026-04-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott', 'IHG', 'British Airways', 'Air France', 'Virgin Atlantic'], '#1a1a2e', '#0d0d1a', 'Premium travel card with Priority Pass, $300 travel credit, 3x travel/dining. Points worth 50% more on portal.', 'https://creditcards.chase.com/rewards-credit-cards/sapphire/reserve'),
  ('Chase Freedom Unlimited', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#0066b2', '#004d86', '1.5% on everything, 3% dining/drugstores, 5% travel via Chase. No annual fee.', 'https://creditcards.chase.com/cash-back-credit-cards/freedom/unlimited'),
  ('Chase Freedom Flex', 'Chase', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#0073cf', '#005299', '5% rotating categories, 3% dining/drugstores. Cell phone protection included.', 'https://creditcards.chase.com/cash-back-credit-cards/freedom/flex'),
  ('Chase Ink Business Preferred', 'Chase', 9500, 100000, 100000, true, 'Spend $8,000 in first 3 months', '2026-06-30', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#1c3a5f', '#0f2439', 'Best business SUB. 3x shipping, travel, internet/cable/phone, advertising up to $150k.', 'https://creditcards.chase.com/business-credit-cards/ink/business-preferred'),
  ('Chase Ink Business Cash', 'Chase', 0, 75000, 90000, false, 'Spend $6,000 in first 3 months', '2026-03-31', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#004e7c', '#003654', '5% office supplies, internet/cable/phone up to $25k. 2% gas/dining.', 'https://creditcards.chase.com/business-credit-cards/ink/cash'),
  ('Chase Ink Business Unlimited', 'Chase', 0, 75000, 90000, false, 'Spend $6,000 in first 3 months', '2026-03-31', 'Ultimate Rewards', ARRAY['United', 'Hyatt', 'Southwest', 'Marriott'], '#005b8f', '#003d5f', 'Flat 1.5% unlimited cash back on all business purchases.', 'https://creditcards.chase.com/business-credit-cards/ink/unlimited'),
  ('World of Hyatt Credit Card', 'Chase', 9500, 60000, 60000, true, 'Spend $6,000 in first 6 months', NULL, 'World of Hyatt Points', ARRAY['Hyatt'], '#6b2d5b', '#4a1f3f', 'Best hotel card value. 4x Hyatt, 2x dining/transit/gym. Free night up to Cat 4 annually.', 'https://creditcards.chase.com/travel-credit-cards/world-of-hyatt-credit-card'),
  ('United Explorer Card', 'Chase', 9500, 60000, 70000, false, 'Spend $3,000 in first 3 months', '2026-05-31', 'United Miles', ARRAY['United'], '#002244', '#001122', '2x United/dining/hotels, free checked bag, priority boarding.', 'https://creditcards.chase.com/travel-credit-cards/united/united-explorer'),
  ('United Quest Card', 'Chase', 25000, 70000, 80000, false, 'Spend $4,000 in first 3 months', '2026-05-31', 'United Miles', ARRAY['United'], '#0033a0', '#001a66', '3x United, 2x dining/hotels. 2 free checked bags, $125 United credit.', 'https://creditcards.chase.com/travel-credit-cards/united/united-quest'),
  ('United Club Infinite Card', 'Chase', 52500, 100000, 100000, true, 'Spend $5,000 in first 3 months', NULL, 'United Miles', ARRAY['United'], '#1a1a2e', '#0d0d1a', 'United Club access, 4x United, Premier Access benefits.', 'https://creditcards.chase.com/travel-credit-cards/united/club-infinite'),
  ('Southwest Rapid Rewards Plus', 'Chase', 6900, 50000, 65000, false, 'Spend $1,000 in first 3 months', NULL, 'Southwest Points', ARRAY['Southwest'], '#304cb2', '#1e3380', '2x Southwest/Rapid Rewards partners. Anniversary 3,000 points.', 'https://creditcards.chase.com/travel-credit-cards/southwest/plus'),
  ('Southwest Rapid Rewards Priority', 'Chase', 14900, 50000, 75000, false, 'Spend $3,000 in first 3 months', NULL, 'Southwest Points', ARRAY['Southwest'], '#ffbf27', '#cc9900', '3x Southwest, $75 annual credit, 7,500 anniversary points.', 'https://creditcards.chase.com/travel-credit-cards/southwest/priority'),
  ('IHG One Rewards Premier', 'Chase', 9900, 140000, 175000, false, 'Spend $3,000 in first 3 months', NULL, 'IHG Points', ARRAY['IHG'], '#004d40', '#003329', '26x IHG, 5x travel/dining/gas. Platinum Elite status, 4th night free.', 'https://creditcards.chase.com/travel-credit-cards/ihg-rewards-club/premier'),
  ('Marriott Bonvoy Boundless', 'Chase', 9500, 85000, 125000, false, 'Spend $3,000 in first 3 months', NULL, 'Marriott Points', ARRAY['Marriott'], '#8b0000', '#660000', '6x Marriott, free night up to 35k annually. Silver Elite status.', 'https://creditcards.chase.com/travel-credit-cards/marriott-bonvoy/boundless')
ON CONFLICT DO NOTHING;

-- ============================================
-- AMERICAN EXPRESS CARDS (20 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('American Express Gold Card', 'Amex', 25000, 60000, 90000, false, 'Spend $6,000 in first 6 months', '2026-05-01', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore', 'Air France', 'British Airways', 'Emirates'], '#b8860b', '#8b6914', '4x restaurants worldwide, 4x US supermarkets up to $25k. $120 dining + $120 Uber credits.', 'https://www.americanexpress.com/us/credit-cards/card/gold-card/'),
  ('American Express Platinum Card', 'Amex', 69500, 80000, 150000, false, 'Spend $8,000 in first 6 months', '2026-05-01', 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore', 'Air France', 'British Airways', 'Emirates'], '#e5e4e2', '#c0c0c0', '5x flights, Centurion Lounge, $200 airline credit, $200 hotel credit, $189 CLEAR.', 'https://www.americanexpress.com/us/credit-cards/card/platinum/'),
  ('American Express Green Card', 'Amex', 15000, 40000, 60000, false, 'Spend $3,000 in first 6 months', NULL, 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore'], '#228b22', '#1a6b1a', '3x travel/transit/dining. Good mid-tier MR earning card.', 'https://www.americanexpress.com/us/credit-cards/card/green/'),
  ('Blue Cash Preferred', 'Amex', 0, 25000, 40000, false, 'Spend $3,000 in first 6 months', NULL, 'Cash Back', NULL, '#0077c8', '#005a99', '6% US supermarkets up to $6k, 6% streaming, 3% transit/gas.', 'https://www.americanexpress.com/us/credit-cards/card/blue-cash-preferred/'),
  ('Blue Cash Everyday', 'Amex', 0, 20000, 25000, false, 'Spend $2,000 in first 6 months', NULL, 'Cash Back', NULL, '#00aaff', '#0088cc', '3% US supermarkets up to $6k, 3% gas, 3% online retail.', 'https://www.americanexpress.com/us/credit-cards/card/blue-cash-everyday/'),
  ('Amex EveryDay Preferred', 'Amex', 9500, 15000, 25000, false, 'Spend $2,000 in first 6 months', NULL, 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore'], '#4169e1', '#2850b8', '3x US supermarkets, 2x gas. 50% bonus for 30+ transactions/month.', 'https://www.americanexpress.com/us/credit-cards/card/amex-everyday-preferred/'),
  ('Delta SkyMiles Gold', 'Amex', 0, 70000, 70000, true, 'Spend $2,000 in first 6 months', '2026-04-15', 'Delta Miles', ARRAY['Delta'], '#86754f', '#6b5d3f', 'No AF Delta card. 2x Delta/restaurants/supermarkets.', 'https://www.americanexpress.com/us/credit-cards/card/delta-skymiles-gold-american-express-card/'),
  ('Delta SkyMiles Platinum', 'Amex', 35000, 90000, 90000, true, 'Spend $4,000 in first 6 months', '2026-04-15', 'Delta Miles', ARRAY['Delta'], '#3d4f5f', '#2d3a47', 'Companion certificate, free checked bag, 3x Delta/hotels.', 'https://www.americanexpress.com/us/credit-cards/card/delta-skymiles-platinum-american-express-card/'),
  ('Delta SkyMiles Reserve', 'Amex', 65000, 80000, 125000, false, 'Spend $6,000 in first 6 months', NULL, 'Delta Miles', ARRAY['Delta'], '#1a1a2e', '#0d0d1a', 'Delta Sky Club access, 3x Delta, companion cert after $30k spend.', 'https://www.americanexpress.com/us/credit-cards/card/delta-skymiles-reserve-american-express-card/'),
  ('Hilton Honors American Express Card', 'Amex', 0, 80000, 100000, false, 'Spend $2,000 in first 6 months', NULL, 'Hilton Points', ARRAY['Hilton'], '#104c8b', '#0a3662', 'No AF, 7x Hilton, 5x dining/gas/grocery. Silver status.', 'https://www.americanexpress.com/us/credit-cards/card/hilton-honors/'),
  ('Hilton Honors Surpass Card', 'Amex', 15000, 130000, 150000, false, 'Spend $3,000 in first 6 months', NULL, 'Hilton Points', ARRAY['Hilton'], '#1a5e9e', '#124578', '12x Hilton, 6x dining/gas/grocery. Gold status, free night after $15k.', 'https://www.americanexpress.com/us/credit-cards/card/hilton-honors-surpass-card/'),
  ('Hilton Honors Aspire Card', 'Amex', 45000, 175000, 175000, true, 'Spend $4,000 in first 6 months', NULL, 'Hilton Points', ARRAY['Hilton'], '#1a1a2e', '#0d0d1a', 'Diamond status, $250 resort credit, $250 airline credit, free night annually.', 'https://www.americanexpress.com/us/credit-cards/card/hilton-honors-aspire-card/'),
  ('Marriott Bonvoy Brilliant', 'Amex', 65000, 95000, 150000, false, 'Spend $6,000 in first 6 months', NULL, 'Marriott Points', ARRAY['Marriott'], '#8b0000', '#660000', 'Platinum Elite, $300 dining credit, free night up to 85k, Priority Pass.', 'https://www.americanexpress.com/us/credit-cards/card/marriott-bonvoy-brilliant/'),
  ('Marriott Bonvoy Bevy', 'Amex', 25000, 85000, 85000, true, 'Spend $3,000 in first 6 months', NULL, 'Marriott Points', ARRAY['Marriott'], '#a52a2a', '#8b2323', 'Gold Elite, 6x Marriott, free night up to 50k annually.', 'https://www.americanexpress.com/us/credit-cards/card/marriott-bonvoy-bevy/'),
  ('Amex Business Gold', 'Amex', 37500, 70000, 100000, false, 'Spend $10,000 in first 3 months', NULL, 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore'], '#b8860b', '#8b6914', '4x on top 2 categories each month (up to $150k combined).', 'https://www.americanexpress.com/us/credit-cards/business/business-credit-cards/american-express-business-gold-card-amex/'),
  ('Amex Business Platinum', 'Amex', 69500, 120000, 170000, false, 'Spend $15,000 in first 3 months', NULL, 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore'], '#e5e4e2', '#c0c0c0', '5x flights/hotels, Centurion Lounge, 35% MR rebate on select airlines.', 'https://www.americanexpress.com/us/credit-cards/business/business-credit-cards/american-express-business-platinum-card-amex/'),
  ('Blue Business Plus', 'Amex', 0, 15000, 15000, true, 'Spend $3,000 in first 6 months', NULL, 'Membership Rewards', ARRAY['Delta', 'Hilton', 'Marriott', 'ANA', 'Singapore'], '#0077c8', '#005a99', '2x MR on all purchases up to $50k/year. Best no-AF business MR card.', 'https://www.americanexpress.com/us/credit-cards/business/business-credit-cards/blue-business-plus-credit-card-amex/'),
  ('Amex Business Cash', 'Amex', 0, 50000, 50000, true, 'Spend $5,000 in first 6 months', NULL, 'Cash Back', NULL, '#00aaff', '#0088cc', '2% on all purchases up to $50k/year, then 1%.', 'https://www.americanexpress.com/us/credit-cards/business/business-credit-cards/blue-business-cash-card-amex/'),
  ('Amazon Business Prime', 'Amex', 0, 12500, 12500, true, '$125 after first purchase', NULL, 'Cash Back', NULL, '#ff9900', '#cc7a00', '5% at Amazon/Whole Foods (with Prime), 2% dining/gas/transit.', 'https://www.americanexpress.com/us/credit-cards/business/business-credit-cards/amazon-business-prime-card/'),
  ('Amex Cobalt Card (Canada)', 'Amex', 15588, 30000, 30000, true, 'Spend $750/mo for 12 months', NULL, 'Membership Rewards', ARRAY['Aeroplan', 'Marriott', 'Hilton'], '#0033a0', '#002266', '5x restaurants/groceries, 2x transit/gas. Best Canadian everyday card.', 'https://www.americanexpress.com/ca/credit-cards/cobalt-card/')
ON CONFLICT DO NOTHING;

-- ============================================
-- CAPITAL ONE CARDS (10 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Capital One Venture X', 'Capital One', 39500, 75000, 100000, false, 'Spend $4,000 in first 3 months', '2026-03-31', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates', 'Singapore', 'Avianca', 'TAP', 'Finnair', 'Air France', 'Etihad'], '#1a1a2e', '#0d0d1a', '10x hotels/cars via portal, 5x flights via portal, 2x everything. $300 travel credit, lounge access.', 'https://www.capitalone.com/credit-cards/venture-x/'),
  ('Capital One Venture', 'Capital One', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', '2026-04-30', 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways', 'Emirates', 'Air France'], '#c41230', '#8b0000', 'Solid 2x everywhere with transfer partners. Easy to earn and redeem.', 'https://www.capitalone.com/credit-cards/venture/'),
  ('Capital One VentureOne', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Capital One Miles', NULL, '#cc2936', '#a11f2b', 'No AF, 1.25x everything. Good starter travel card.', 'https://www.capitalone.com/credit-cards/ventureone/'),
  ('Capital One Savor', 'Capital One', 9500, 30000, 30000, true, 'Spend $3,000 in first 3 months', NULL, 'Cash Back', NULL, '#b22234', '#8b1a28', '4% dining/entertainment, 4% streaming, 3% grocery.', 'https://www.capitalone.com/credit-cards/savor-dining-rewards/'),
  ('Capital One SavorOne', 'Capital One', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Cash Back', NULL, '#cc2936', '#a11f2b', 'No AF: 3% dining/entertainment/streaming/grocery.', 'https://www.capitalone.com/credit-cards/savorone-dining-rewards/'),
  ('Capital One Quicksilver', 'Capital One', 0, 20000, 20000, true, '$200 after $500 spend', NULL, 'Cash Back', NULL, '#4a4a4a', '#333333', 'Simple 1.5% unlimited on everything.', 'https://www.capitalone.com/credit-cards/quicksilver/'),
  ('Capital One Spark Cash Plus', 'Capital One', 15000, 50000, 100000, false, 'Spend $5,000 in first 3 months', NULL, 'Cash Back', NULL, '#1a1a2e', '#0d0d1a', 'Unlimited 2% on all business purchases. Charge card.', 'https://www.capitalone.com/small-business/credit-cards/spark-cash-plus/'),
  ('Capital One Spark Miles', 'Capital One', 9500, 50000, 50000, true, 'Spend $4,500 in first 3 months', NULL, 'Capital One Miles', ARRAY['Turkish', 'Air Canada', 'British Airways'], '#c41230', '#8b0000', '2x miles on every business purchase.', 'https://www.capitalone.com/small-business/credit-cards/spark-miles/'),
  ('Capital One Walmart Rewards', 'Capital One', 0, 0, 0, true, '5% back first 12 months', NULL, 'Cash Back', NULL, '#0071ce', '#005299', '5% Walmart.com (first year), 2% Walmart/restaurants/travel, 1% everywhere.', 'https://www.walmart.com/cp/walmart-credit-card/632402'),
  ('Capital One Platinum', 'Capital One', 0, 0, 0, true, 'No SUB', NULL, 'N/A', NULL, '#4a4a4a', '#333333', 'Credit building card with no deposit required.', 'https://www.capitalone.com/credit-cards/platinum/')
ON CONFLICT DO NOTHING;

-- ============================================
-- CITI CARDS (10 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Citi Strata Premier', 'Citi', 9500, 75000, 75000, true, 'Spend $4,000 in first 3 months', '2026-05-15', 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'Virgin Atlantic', 'JetBlue', 'Avianca', 'Air France', 'Emirates', 'Etihad', 'Qatar', 'Cathay Pacific'], '#003b70', '#002244', '3x travel/gas/groceries/dining. Great transfer partners including Singapore.', 'https://www.citi.com/credit-cards/citi-strata-premier-credit-card'),
  ('Citi Double Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', NULL, 'Cash Back / ThankYou Points', NULL, '#1a4480', '#0e2d54', '2% on everything (1% buy + 1% pay). Can convert to TYP.', 'https://www.citi.com/credit-cards/citi-double-cash-credit-card'),
  ('Citi Custom Cash Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', NULL, 'Cash Back / ThankYou Points', NULL, '#2e5c8a', '#1a3d5c', 'Auto 5% in top spend category each month up to $500.', 'https://www.citi.com/credit-cards/citi-custom-cash-credit-card'),
  ('Citi Premier Card', 'Citi', 9500, 60000, 80000, false, 'Spend $4,000 in first 3 months', NULL, 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'Virgin Atlantic', 'JetBlue', 'Air France'], '#003b70', '#002244', '3x air travel/hotels, dining, gas, supermarkets.', 'https://www.citi.com/credit-cards/citi-premier-credit-card'),
  ('Citi Rewards+ Card', 'Citi', 0, 20000, 20000, true, 'Spend $1,500 in first 6 months', NULL, 'ThankYou Points', ARRAY['Singapore', 'Turkish', 'JetBlue'], '#0066b2', '#004d86', '2x supermarkets/gas up to $6k, round up to 10 points.', 'https://www.citi.com/credit-cards/citi-rewards-plus-credit-card'),
  ('Citi AAdvantage Platinum Select', 'Citi', 9900, 50000, 75000, false, 'Spend $2,500 in first 3 months', NULL, 'AAdvantage Miles', ARRAY['American Airlines'], '#0078d4', '#005599', '2x American/restaurants/gas, first checked bag free.', 'https://www.citi.com/credit-cards/citi-aadvantage-platinum-select-credit-card'),
  ('Citi AAdvantage Executive', 'Citi', 59500, 70000, 100000, false, 'Spend $7,000 in first 3 months', NULL, 'AAdvantage Miles', ARRAY['American Airlines'], '#1a1a2e', '#0d0d1a', 'Admirals Club access, 10k miles + $100 after $40k spend.', 'https://www.citi.com/credit-cards/citi-aadvantage-executive-credit-card'),
  ('Costco Anywhere Visa', 'Citi', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#e31837', '#b3001b', '4% gas up to $7k, 3% restaurants/travel, 2% Costco, 1% everything. Requires Costco membership.', 'https://www.citi.com/credit-cards/citi-costco-anywhere-visa-credit-card'),
  ('Citi Simplicity', 'Citi', 0, 0, 0, true, 'No SUB', NULL, 'N/A', NULL, '#4a4a4a', '#333333', 'No late fees ever, 0% intro APR for 21 months.', 'https://www.citi.com/credit-cards/citi-simplicity-credit-card'),
  ('Citi Diamond Preferred', 'Citi', 0, 0, 0, true, 'No SUB', NULL, 'N/A', NULL, '#4169e1', '#2850b8', '0% intro APR for 21 months on balance transfers.', 'https://www.citi.com/credit-cards/citi-diamond-preferred-credit-card')
ON CONFLICT DO NOTHING;

-- ============================================
-- BANK OF AMERICA CARDS (8 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Bank of America Premium Rewards', 'Bank of America', 9500, 60000, 75000, false, 'Spend $4,000 in first 90 days', NULL, 'Cash Back', NULL, '#012169', '#001040', '2x travel/dining, $100 airline credit, TSA PreCheck credit.', 'https://www.bankofamerica.com/credit-cards/products/premium-rewards-credit-card/'),
  ('Bank of America Premium Rewards Elite', 'Bank of America', 55000, 60000, 75000, false, 'Spend $5,000 in first 90 days', NULL, 'Cash Back', NULL, '#1a1a2e', '#0d0d1a', '2x all purchases (up to $50k), unlimited lounge visits, $150 lifestyle credit.', 'https://www.bankofamerica.com/credit-cards/products/premium-rewards-elite-credit-card/'),
  ('Bank of America Customized Cash Rewards', 'Bank of America', 0, 20000, 20000, true, 'Spend $1,000 in first 90 days', NULL, 'Cash Back', NULL, '#e31837', '#b3001b', '3% in choice category, 2% grocery/wholesale up to $2,500/quarter.', 'https://www.bankofamerica.com/credit-cards/products/cash-back-credit-card/'),
  ('Bank of America Unlimited Cash Rewards', 'Bank of America', 0, 20000, 20000, true, 'Spend $1,000 in first 90 days', NULL, 'Cash Back', NULL, '#012169', '#001040', '1.5% unlimited on everything.', 'https://www.bankofamerica.com/credit-cards/products/unlimited-cash-back-credit-card/'),
  ('Bank of America Travel Rewards', 'Bank of America', 0, 25000, 25000, true, 'Spend $1,000 in first 90 days', NULL, 'Travel Points', NULL, '#0073cf', '#005299', '1.5x on everything, no foreign transaction fees.', 'https://www.bankofamerica.com/credit-cards/products/travel-rewards-credit-card/'),
  ('Alaska Airlines Visa Signature', 'Bank of America', 9500, 70000, 70000, true, 'Spend $3,000 in first 90 days', NULL, 'Alaska Miles', ARRAY['Alaska Airlines'], '#01426a', '#002d4a', '3x Alaska, 2x gas/transit/streaming, companion fare annually.', 'https://www.bankofamerica.com/credit-cards/products/alaska-airlines-credit-card/'),
  ('Alaska Airlines Visa Business', 'Bank of America', 7500, 60000, 60000, true, 'Spend $2,000 in first 90 days', NULL, 'Alaska Miles', ARRAY['Alaska Airlines'], '#01426a', '#002d4a', '3x Alaska, companion fare annually, 10% miles back.', 'https://www.bankofamerica.com/credit-cards/products/alaska-airlines-business-credit-card/'),
  ('Bank of America Business Advantage', 'Bank of America', 0, 30000, 30000, true, 'Spend $3,000 in first 90 days', NULL, 'Cash Back', NULL, '#012169', '#001040', '3% in choice category, 2% dining.', 'https://www.bankofamerica.com/smallbusiness/credit-cards/products/business-advantage-customized-cash-rewards-credit-card/')
ON CONFLICT DO NOTHING;

-- ============================================
-- US BANK CARDS (6 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('US Bank Altitude Reserve', 'US Bank', 40000, 50000, 75000, false, 'Spend $4,500 in first 90 days', NULL, 'Altitude Points', NULL, '#0033a0', '#001f5c', '3x travel/mobile wallet, $325 travel credit, Priority Pass.', 'https://www.usbank.com/credit-cards/altitude-reserve-visa-infinite-credit-card.html'),
  ('US Bank Altitude Go', 'US Bank', 0, 25000, 25000, true, 'Spend $1,000 in first 90 days', NULL, 'Altitude Points', NULL, '#0033a0', '#002266', '4x dining, 2x groceries/gas/streaming. Best no-AF dining card.', 'https://www.usbank.com/credit-cards/altitude-go-visa-signature-credit-card.html'),
  ('US Bank Altitude Connect', 'US Bank', 9500, 50000, 60000, false, 'Spend $2,500 in first 120 days', NULL, 'Altitude Points', NULL, '#0073cf', '#005299', '5x hotels/car rentals, 4x gas/EV charging, 2x grocery/dining.', 'https://www.usbank.com/credit-cards/altitude-connect-visa-signature-credit-card.html'),
  ('US Bank Cash+', 'US Bank', 0, 20000, 20000, true, 'Spend $1,000 in first 120 days', NULL, 'Cash Back', NULL, '#004d99', '#003366', 'Choose 2 categories for 5% up to $2k combined/quarter.', 'https://www.usbank.com/credit-cards/cash-plus-visa-signature-credit-card.html'),
  ('US Bank Shopper Cash Rewards', 'US Bank', 0, 20000, 20000, true, 'Spend $1,000 in first 120 days', NULL, 'Cash Back', NULL, '#0066b2', '#004d86', '6% click-through shopping, 3% eligible streaming, 1.5% everything else.', 'https://www.usbank.com/credit-cards/shopper-cash-rewards-visa-signature-credit-card.html'),
  ('US Bank Business Triple Cash', 'US Bank', 0, 50000, 50000, true, 'Spend $4,500 in first 150 days', NULL, 'Cash Back', NULL, '#0033a0', '#001f5c', '3% gas/office supplies/cell phone/restaurants, 1% everything.', 'https://www.usbank.com/credit-cards/business-triple-cash-rewards-world-elite-mastercard.html')
ON CONFLICT DO NOTHING;

-- ============================================
-- WELLS FARGO CARDS (5 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Wells Fargo Autograph', 'Wells Fargo', 0, 20000, 30000, false, 'Spend $1,500 in first 3 months', NULL, 'Points', NULL, '#d71e28', '#a3161d', '3x restaurants/travel/gas/transit/streaming/phone plans.', 'https://www.wellsfargo.com/credit-cards/autograph-card/'),
  ('Wells Fargo Autograph Journey', 'Wells Fargo', 9500, 60000, 60000, true, 'Spend $4,000 in first 3 months', NULL, 'Points', NULL, '#d71e28', '#a3161d', '5x hotels, 4x airlines, 3x dining/transit/gas/streaming.', 'https://www.wellsfargo.com/credit-cards/autograph-journey/'),
  ('Wells Fargo Active Cash', 'Wells Fargo', 0, 20000, 20000, true, 'Spend $500 in first 3 months', NULL, 'Cash Back', NULL, '#cd1309', '#a30f07', 'Simple 2% unlimited on everything.', 'https://www.wellsfargo.com/credit-cards/active-cash/'),
  ('Wells Fargo Attune', 'Wells Fargo', 0, 20000, 20000, true, 'Spend $1,000 in first 3 months', NULL, 'Cash Back', NULL, '#228b22', '#1a6b1a', '4% on select "green" purchases, 2% everything else. Eco-focused card.', 'https://www.wellsfargo.com/credit-cards/attune/'),
  ('Wells Fargo Reflect', 'Wells Fargo', 0, 0, 0, true, 'No SUB', NULL, 'N/A', NULL, '#4a4a4a', '#333333', '0% intro APR for up to 21 months.', 'https://www.wellsfargo.com/credit-cards/reflect/')
ON CONFLICT DO NOTHING;

-- ============================================
-- DISCOVER CARDS (3 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Discover it Cash Back', 'Discover', 0, 0, 0, true, 'Cashback Match first year', NULL, 'Cash Back', NULL, '#ff6600', '#cc5200', '5% rotating quarterly categories, 1% everything. ALL CASH BACK MATCHED first year = 10%/2%!', 'https://www.discover.com/credit-cards/cash-back/it-card.html'),
  ('Discover it Miles', 'Discover', 0, 0, 0, true, 'Miles Match first year', NULL, 'Miles', NULL, '#ff6600', '#cc5200', '1.5x unlimited miles. ALL MILES MATCHED first year = 3x!', 'https://www.discover.com/credit-cards/travel/it-miles.html'),
  ('Discover it Chrome', 'Discover', 0, 0, 0, true, 'Cashback Match first year', NULL, 'Cash Back', NULL, '#c0c0c0', '#a0a0a0', '2% restaurants/gas up to $1k/quarter, 1% everything. Cash back matched.', 'https://www.discover.com/credit-cards/cash-back/chrome-card.html')
ON CONFLICT DO NOTHING;

-- ============================================
-- BARCLAYS CARDS (8 cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Barclays AAdvantage Aviator Red', 'Barclays', 9900, 60000, 75000, false, 'First purchase + pay AF', NULL, 'AAdvantage Miles', ARRAY['American Airlines'], '#c41230', '#8b0000', 'Easiest SUB ever - just one purchase! First checked bag free.', 'https://cards.barclaycardus.com/banking/cards/aadvantage-aviator-red-world-elite-mastercard/'),
  ('Barclays AAdvantage Aviator Silver', 'Barclays', 14900, 75000, 75000, true, 'First purchase + pay AF', NULL, 'AAdvantage Miles', ARRAY['American Airlines'], '#c0c0c0', '#a0a0a0', '2x AA, $50 AA credit, first checked bag free.', 'https://cards.barclaycardus.com/banking/cards/aadvantage-aviator-silver-world-elite-mastercard/'),
  ('JetBlue Plus Card', 'Barclays', 9900, 80000, 80000, true, 'Spend $1,000 in first 90 days', NULL, 'TrueBlue Points', ARRAY['JetBlue'], '#003087', '#002266', '6x JetBlue, 2x restaurants/grocery. 5k anniversary points.', 'https://cards.barclaycardus.com/banking/cards/jetblue-plus-card/'),
  ('JetBlue Business Card', 'Barclays', 9900, 80000, 80000, true, 'Spend $1,000 in first 90 days', NULL, 'TrueBlue Points', ARRAY['JetBlue'], '#003087', '#002266', '6x JetBlue, 2x restaurants/office supplies.', 'https://cards.barclaycardus.com/banking/cards/jetblue-business-card/'),
  ('Wyndham Rewards Earner Plus', 'Barclays', 7500, 75000, 75000, true, 'Spend $1,000 in first 90 days', NULL, 'Wyndham Points', ARRAY['Wyndham'], '#004990', '#003366', '6x Wyndham, 5x gas. Gold status.', 'https://cards.barclaycardus.com/banking/cards/wyndham-rewards-earner-plus-card/'),
  ('Wyndham Rewards Earner Business', 'Barclays', 9500, 75000, 75000, true, 'Spend $1,000 in first 90 days', NULL, 'Wyndham Points', ARRAY['Wyndham'], '#004990', '#003366', '8x Wyndham, 5x utilities, Diamond status.', 'https://cards.barclaycardus.com/banking/cards/wyndham-rewards-earner-business-card/'),
  ('Hawaiian Airlines World Elite', 'Barclays', 9900, 70000, 70000, true, 'Spend $2,000 in first 90 days', NULL, 'HawaiianMiles', ARRAY['Hawaiian Airlines'], '#5c2d91', '#401f66', '3x Hawaiian/gas/dining, 1 companion discount.', 'https://cards.barclaycardus.com/banking/cards/hawaiian-airlines-world-elite-mastercard/'),
  ('Barclays View Mastercard', 'Barclays', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#00aaff', '#0088cc', '0% intro APR, no forex fees. Good starter card.', 'https://cards.barclaycardus.com/banking/cards/barclays-view-mastercard/')
ON CONFLICT DO NOTHING;

-- ============================================
-- OTHER ISSUERS (15+ cards)
-- ============================================
INSERT INTO credit_cards (name, issuer, annual_fee, current_sub, highest_sub, is_at_highest, sub_requirements, sub_end_date, point_type, transfer_partners, card_color, card_color_end, description, official_url) VALUES
  ('Bilt Mastercard', 'Wells Fargo', 0, 0, 0, true, 'No SUB - earn on rent!', NULL, 'Bilt Points', ARRAY['Hyatt', 'United', 'American', 'Air Canada', 'Turkish', 'IHG', 'Hawaiian'], '#1a1a2e', '#0d0d1a', 'Only card earning points on rent with no fees. 1x rent, 3x dining, 2x travel. Great transfers.', 'https://www.biltrewards.com/card'),
  ('Apple Card', 'Goldman Sachs', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#f5f5f7', '#e8e8ed', '3% Apple/Uber/Nike/etc, 2% Apple Pay, 1% everything. Daily Cash.', 'https://www.apple.com/apple-card/'),
  ('Citi Costco Anywhere Visa', 'Citi', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#e31837', '#b3001b', '4% gas up to $7k, 3% restaurants/travel, 2% Costco. Costco membership required.', 'https://www.citi.com/credit-cards/citi-costco-anywhere-visa-credit-card'),
  ('Amazon Prime Rewards Visa', 'Chase', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#ff9900', '#cc7a00', '5% Amazon/Whole Foods (with Prime), 2% restaurants/gas/drugstores.', 'https://www.amazon.com/Amazon-Prime-Rewards-Visa-Signature/dp/B007URFTYI'),
  ('Target RedCard Credit', 'TD Bank', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#cc0000', '#990000', '5% at Target and Target.com. Free 2-day shipping.', 'https://www.target.com/redcard'),
  ('PayPal Cashback Mastercard', 'Synchrony', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#003087', '#002266', '3% PayPal purchases, 2% everywhere else.', 'https://www.paypal.com/us/digital-wallet/manage-money/paypal-cashback-mastercard'),
  ('Venmo Credit Card', 'Synchrony', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#008cff', '#006bb3', 'Auto 3% top category, 2% second, 1% everything. Cash back to Venmo.', 'https://venmo.com/credit-card/'),
  ('SoFi Credit Card', 'SoFi', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#53c8b2', '#3fa897', '2% unlimited (with direct deposit), points can invest.', 'https://www.sofi.com/credit-card/'),
  ('Robinhood Gold Card', 'Coastal Community Bank', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#00c805', '#009904', '3% on everything (with Gold subscription), earns to brokerage.', 'https://robinhood.com/creditcard/'),
  ('X1 Card', 'Coastal Community Bank', 0, 0, 0, true, 'No SUB', NULL, 'Points', NULL, '#1a1a2e', '#0d0d1a', '2x-4x depending on spend. Metal card, virtual cards, no forex fees.', 'https://x1.co'),
  ('Petal 2 Visa', 'WebBank', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#3cb371', '#2e8b57', '1-1.5% cash back, credit building, no fees. Good starter card.', 'https://www.petalcard.com/petal-2'),
  ('Upgrade Cash Rewards Visa', 'Upgrade', 0, 0, 0, true, '$200 after $3k spend', NULL, 'Cash Back', NULL, '#0073cf', '#005299', '1.5% unlimited, combines credit card and personal loan features.', 'https://www.upgrade.com/rewards-checking-cards/cash-rewards-visa/'),
  ('Credit One Bank Platinum X5 Visa', 'Credit One', 0, 0, 0, true, 'No SUB', NULL, 'Cash Back', NULL, '#0033a0', '#002266', '5% hotels/rentals via portal, 2% gas/grocery. Credit building.', 'https://www.creditonebank.com/credit-cards/platinum-x5-visa'),
  ('Bread Cashback American Express', 'Bread Financial', 0, 0, 0, true, '$200 after $1.5k spend', NULL, 'Cash Back', NULL, '#ff6b35', '#cc5629', '2% unlimited cash back.', 'https://www.breadfinancial.com/en/solutions/bread-cashback.html'),
  ('PNC Cash Rewards Visa', 'PNC', 0, 0, 0, true, '$100 after $1k spend', NULL, 'Cash Back', NULL, '#ff5f00', '#cc4c00', '4% gas, 3% dining, 2% grocery, 1% everything.', 'https://www.pnc.com/en/personal-banking/banking/credit-cards/pnc-cash-rewards-visa.html')
ON CONFLICT DO NOTHING;

-- Add card rewards for key cards (abbreviated for length)
-- Chase Sapphire Preferred
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants and eligible delivery' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'streaming', 3, 'points_per_dollar', NULL, 'Select streaming services' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'travel', 2, 'points_per_dollar', NULL, 'All travel' FROM credit_cards WHERE name = 'Chase Sapphire Preferred' ON CONFLICT DO NOTHING;

-- Amex Gold
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 4, 'points_per_dollar', NULL, 'Restaurants worldwide' FROM credit_cards WHERE name = 'American Express Gold Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'grocery', 4, 'points_per_dollar', 2500000, 'US supermarkets up to $25k/year' FROM credit_cards WHERE name = 'American Express Gold Card' ON CONFLICT DO NOTHING;

-- Blue Cash Preferred
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'grocery', 6, 'percent', 600000, 'US supermarkets up to $6k/year' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'streaming', 6, 'percent', NULL, 'Select streaming' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'transit', 3, 'percent', NULL, 'Transit/rideshare' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'gas', 3, 'percent', NULL, 'US gas stations' FROM credit_cards WHERE name = 'Blue Cash Preferred' ON CONFLICT DO NOTHING;

-- Citi Strata Premier
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'travel', 3, 'points_per_dollar', NULL, 'Air/hotels' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'grocery', 3, 'points_per_dollar', NULL, 'Supermarkets' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'gas', 3, 'points_per_dollar', NULL, 'Gas stations' FROM credit_cards WHERE name = 'Citi Strata Premier' ON CONFLICT DO NOTHING;

-- Capital One Venture X
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'travel', 10, 'points_per_dollar', NULL, 'Hotels/cars via Capital One Travel' FROM credit_cards WHERE name = 'Capital One Venture X' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'other', 2, 'points_per_dollar', NULL, 'All other purchases' FROM credit_cards WHERE name = 'Capital One Venture X' ON CONFLICT DO NOTHING;

-- US Bank Altitude Go  
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 4, 'points_per_dollar', NULL, 'Restaurants and takeout' FROM credit_cards WHERE name = 'US Bank Altitude Go' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'grocery', 2, 'points_per_dollar', NULL, 'Grocery stores' FROM credit_cards WHERE name = 'US Bank Altitude Go' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'gas', 2, 'points_per_dollar', NULL, 'Gas stations' FROM credit_cards WHERE name = 'US Bank Altitude Go' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'streaming', 2, 'points_per_dollar', NULL, 'Streaming services' FROM credit_cards WHERE name = 'US Bank Altitude Go' ON CONFLICT DO NOTHING;

-- Flat 2% cards
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'other', 2, 'percent', NULL, 'Unlimited 2%' FROM credit_cards WHERE name = 'Citi Double Cash Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'other', 2, 'percent', NULL, 'Unlimited 2%' FROM credit_cards WHERE name = 'Wells Fargo Active Cash' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'other', 1.5, 'percent', NULL, 'Unlimited 1.5%' FROM credit_cards WHERE name = 'Chase Freedom Unlimited' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'other', 1.5, 'percent', NULL, 'Unlimited 1.5%' FROM credit_cards WHERE name = 'Capital One Quicksilver' ON CONFLICT DO NOTHING;

-- Bilt Mastercard
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 3, 'points_per_dollar', NULL, 'Restaurants' FROM credit_cards WHERE name = 'Bilt Mastercard' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'travel', 2, 'points_per_dollar', NULL, 'Travel purchases' FROM credit_cards WHERE name = 'Bilt Mastercard' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'rent', 1, 'points_per_dollar', NULL, 'Rent payments (no fees!)' FROM credit_cards WHERE name = 'Bilt Mastercard' ON CONFLICT DO NOTHING;

-- World of Hyatt
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'travel', 4, 'points_per_dollar', NULL, 'Hyatt properties' FROM credit_cards WHERE name = 'World of Hyatt Credit Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'dining', 2, 'points_per_dollar', NULL, 'Restaurants' FROM credit_cards WHERE name = 'World of Hyatt Credit Card' ON CONFLICT DO NOTHING;
INSERT INTO card_rewards (card_id, category, reward_rate, reward_unit, cap_amount, notes) SELECT id, 'transit', 2, 'points_per_dollar', NULL, 'Transit and commuting' FROM credit_cards WHERE name = 'World of Hyatt Credit Card' ON CONFLICT DO NOTHING;
