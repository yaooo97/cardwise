#!/usr/bin/env python3
"""
Credit Card Data Sync Script

This script reads card data from data/cards.json and syncs it to Supabase.
Run manually or via GitHub Actions every 2 days.

Usage:
    python scripts/sync_cards.py
"""

import os
import json
from datetime import datetime
from supabase import create_client, Client

def load_cards_data():
    """Load card data from JSON file."""
    data_file = os.path.join(os.path.dirname(__file__), '..', 'data', 'cards.json')
    
    if not os.path.exists(data_file):
        print(f"Data file not found: {data_file}")
        return None
    
    with open(data_file, 'r') as f:
        return json.load(f)

def sync_to_supabase(supabase: Client, cards_data: dict):
    """Sync card data to Supabase."""
    
    # Sync credit cards
    cards = cards_data.get('credit_cards', [])
    print(f"Syncing {len(cards)} credit cards...")
    
    for card in cards:
        # Check if card exists by name and issuer
        existing = supabase.table('credit_cards').select('id').eq('name', card['name']).eq('issuer', card['issuer']).execute()
        
        if existing.data:
            # Update existing card
            card_id = existing.data[0]['id']
            supabase.table('credit_cards').update({
                'current_sub': card.get('current_sub', 0),
                'highest_sub': card.get('highest_sub', 0),
                'is_at_highest': card.get('is_at_highest', False),
                'sub_requirements': card.get('sub_requirements'),
                'sub_end_date': card.get('sub_end_date'),
                'apply_url': card.get('apply_url'),
                'official_url': card.get('official_url'),
                'description': card.get('description'),
                'updated_at': datetime.now().isoformat()
            }).eq('id', card_id).execute()
            print(f"  Updated: {card['name']}")
        else:
            # Insert new card
            supabase.table('credit_cards').insert({
                'name': card['name'],
                'issuer': card['issuer'],
                'annual_fee': card.get('annual_fee', 0),
                'current_sub': card.get('current_sub', 0),
                'highest_sub': card.get('highest_sub', 0),
                'is_at_highest': card.get('is_at_highest', False),
                'sub_requirements': card.get('sub_requirements'),
                'sub_end_date': card.get('sub_end_date'),
                'point_type': card.get('point_type'),
                'transfer_partners': card.get('transfer_partners'),
                'card_color': card.get('card_color', '#1a1a2e'),
                'card_color_end': card.get('card_color_end', '#16213e'),
                'apply_url': card.get('apply_url'),
                'official_url': card.get('official_url'),
                'description': card.get('description')
            }).execute()
            print(f"  Inserted: {card['name']}")
    
    # Sync rewards if present
    rewards = cards_data.get('card_rewards', [])
    if rewards:
        print(f"\nSyncing {len(rewards)} reward entries...")
        for reward in rewards:
            # Find card ID by name
            card_result = supabase.table('credit_cards').select('id').eq('name', reward['card_name']).execute()
            if card_result.data:
                card_id = card_result.data[0]['id']
                
                # Check if reward exists
                existing_reward = supabase.table('card_rewards').select('id').eq('card_id', card_id).eq('category', reward['category']).execute()
                
                if existing_reward.data:
                    # Update
                    supabase.table('card_rewards').update({
                        'reward_rate': reward['reward_rate'],
                        'reward_unit': reward.get('reward_unit', 'percent'),
                        'cap_amount': reward.get('cap_amount'),
                        'notes': reward.get('notes')
                    }).eq('id', existing_reward.data[0]['id']).execute()
                else:
                    # Insert
                    supabase.table('card_rewards').insert({
                        'card_id': card_id,
                        'category': reward['category'],
                        'reward_rate': reward['reward_rate'],
                        'reward_unit': reward.get('reward_unit', 'percent'),
                        'cap_amount': reward.get('cap_amount'),
                        'notes': reward.get('notes')
                    }).execute()

def main():
    # Load environment variables
    supabase_url = os.environ.get('SUPABASE_URL')
    supabase_key = os.environ.get('SUPABASE_SERVICE_KEY')
    
    if not supabase_url or not supabase_key:
        print("Error: SUPABASE_URL and SUPABASE_SERVICE_KEY must be set")
        print("Set them as environment variables or GitHub secrets")
        return
    
    # Connect to Supabase
    supabase = create_client(supabase_url, supabase_key)
    print("Connected to Supabase")
    
    # Load card data
    cards_data = load_cards_data()
    if not cards_data:
        print("No data to sync")
        return
    
    # Sync to database
    sync_to_supabase(supabase, cards_data)
    
    print(f"\nSync completed at {datetime.now().isoformat()}")

if __name__ == '__main__':
    main()
