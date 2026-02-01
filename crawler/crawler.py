#!/usr/bin/env python3
"""
Credit Card Data Crawler

This script helps maintain credit card data by:
1. Fetching current SUB offers from various sources
2. Comparing with existing database records
3. Generating reports of changes for manual review
4. Updating the database after approval

Usage:
    python crawler.py --check    # Check for SUB changes
    python crawler.py --update   # Update database (after review)
    python crawler.py --export   # Export current data to JSON
"""

import os
import json
import argparse
from datetime import datetime
from typing import Optional
from dotenv import load_dotenv

# Load environment variables
load_dotenv()

# Try to import optional dependencies
try:
    import requests
    from bs4 import BeautifulSoup
    SCRAPING_AVAILABLE = True
except ImportError:
    SCRAPING_AVAILABLE = False
    print("Warning: requests/beautifulsoup4 not installed. Scraping features disabled.")

try:
    from supabase import create_client, Client
    SUPABASE_AVAILABLE = True
except ImportError:
    SUPABASE_AVAILABLE = False
    print("Warning: supabase not installed. Database features disabled.")


class CreditCardCrawler:
    """Crawler for credit card sign-up bonus data."""
    
    def __init__(self):
        self.supabase: Optional[Client] = None
        self.data_file = os.path.join(os.path.dirname(__file__), 'cards_data.json')
        
        if SUPABASE_AVAILABLE:
            url = os.environ.get("SUPABASE_URL")
            key = os.environ.get("SUPABASE_SERVICE_KEY")
            if url and key:
                self.supabase = create_client(url, key)
    
    def fetch_cards_from_db(self) -> list:
        """Fetch all credit cards from the database."""
        if not self.supabase:
            print("Database not connected. Using local data file.")
            return self.load_local_data()
        
        response = self.supabase.table('credit_cards').select('*').execute()
        return response.data
    
    def load_local_data(self) -> list:
        """Load card data from local JSON file."""
        if os.path.exists(self.data_file):
            with open(self.data_file, 'r') as f:
                return json.load(f)
        return []
    
    def save_local_data(self, cards: list):
        """Save card data to local JSON file."""
        with open(self.data_file, 'w') as f:
            json.dump(cards, f, indent=2, default=str)
        print(f"Saved {len(cards)} cards to {self.data_file}")
    
    def export_data(self):
        """Export current database to JSON file."""
        cards = self.fetch_cards_from_db()
        self.save_local_data(cards)
        return cards
    
    def check_for_changes(self) -> dict:
        """
        Check for SUB changes by comparing with known sources.
        Returns a report of potential changes for manual review.
        """
        cards = self.fetch_cards_from_db()
        report = {
            'timestamp': datetime.now().isoformat(),
            'total_cards': len(cards),
            'at_highest': [],
            'below_highest': [],
            'needs_review': []
        }
        
        for card in cards:
            card_info = {
                'name': card['name'],
                'issuer': card['issuer'],
                'current_sub': card['current_sub'],
                'highest_sub': card['highest_sub'],
                'is_at_highest': card['is_at_highest']
            }
            
            if card['is_at_highest']:
                report['at_highest'].append(card_info)
            elif card['current_sub'] < card['highest_sub']:
                report['below_highest'].append(card_info)
        
        return report
    
    def generate_report(self, report: dict):
        """Generate a human-readable report."""
        print("\n" + "=" * 60)
        print("CREDIT CARD SUB REPORT")
        print(f"Generated: {report['timestamp']}")
        print("=" * 60)
        
        print(f"\nTotal Cards: {report['total_cards']}")
        print(f"At All-Time High: {len(report['at_highest'])}")
        print(f"Below Highest: {len(report['below_highest'])}")
        
        if report['at_highest']:
            print("\n--- Cards at All-Time High SUB ---")
            for card in report['at_highest']:
                sub_value = card['current_sub'] / 100
                print(f"  ✓ {card['name']} ({card['issuer']}): ${sub_value:,.0f}")
        
        if report['below_highest']:
            print("\n--- Cards Below Historical High ---")
            for card in report['below_highest']:
                current = card['current_sub'] / 100
                highest = card['highest_sub'] / 100
                diff = highest - current
                print(f"  • {card['name']} ({card['issuer']})")
                print(f"    Current: ${current:,.0f} | Highest: ${highest:,.0f} | Diff: ${diff:,.0f}")
        
        print("\n" + "=" * 60)
    
    def update_card_sub(self, card_name: str, new_sub: int, is_at_highest: bool = None):
        """
        Update a card's SUB value in the database.
        
        Args:
            card_name: The name of the credit card
            new_sub: New SUB value in cents
            is_at_highest: Whether this is an all-time high
        """
        if not self.supabase:
            print("Database not connected. Cannot update.")
            return False
        
        update_data = {
            'current_sub': new_sub,
            'updated_at': datetime.now().isoformat()
        }
        
        if is_at_highest is not None:
            update_data['is_at_highest'] = is_at_highest
        
        # If new SUB is higher than recorded highest, update that too
        cards = self.supabase.table('credit_cards').select('highest_sub').eq('name', card_name).execute()
        if cards.data and new_sub > cards.data[0]['highest_sub']:
            update_data['highest_sub'] = new_sub
            update_data['is_at_highest'] = True
        
        response = self.supabase.table('credit_cards').update(update_data).eq('name', card_name).execute()
        
        if response.data:
            print(f"Updated {card_name}: SUB = ${new_sub/100:,.0f}")
            return True
        else:
            print(f"Failed to update {card_name}")
            return False
    
    def scrape_doctor_of_credit(self) -> list:
        """
        Scrape SUB data from Doctor of Credit (example).
        Note: This is a template - actual implementation would need
        to respect robots.txt and terms of service.
        """
        if not SCRAPING_AVAILABLE:
            print("Scraping libraries not available.")
            return []
        
        # This is a placeholder - actual scraping would go here
        # In practice, you might want to:
        # 1. Check robots.txt
        # 2. Respect rate limits
        # 3. Parse specific pages for SUB information
        
        print("Note: Scraping is disabled by default.")
        print("Manual data entry is recommended to ensure accuracy.")
        return []


def main():
    parser = argparse.ArgumentParser(description='Credit Card Data Crawler')
    parser.add_argument('--check', action='store_true', help='Check for SUB changes')
    parser.add_argument('--update', action='store_true', help='Update database')
    parser.add_argument('--export', action='store_true', help='Export data to JSON')
    parser.add_argument('--card', type=str, help='Card name for update')
    parser.add_argument('--sub', type=int, help='New SUB value in dollars')
    parser.add_argument('--highest', action='store_true', help='Mark as all-time high')
    
    args = parser.parse_args()
    crawler = CreditCardCrawler()
    
    if args.check:
        report = crawler.check_for_changes()
        crawler.generate_report(report)
    
    elif args.export:
        cards = crawler.export_data()
        print(f"Exported {len(cards)} cards")
    
    elif args.update and args.card and args.sub:
        # Convert dollars to cents
        sub_cents = args.sub * 100
        crawler.update_card_sub(args.card, sub_cents, args.highest if args.highest else None)
    
    else:
        parser.print_help()
        print("\nExamples:")
        print("  python crawler.py --check")
        print("  python crawler.py --export")
        print('  python crawler.py --update --card "Chase Sapphire Preferred" --sub 75000 --highest')


if __name__ == '__main__':
    main()
