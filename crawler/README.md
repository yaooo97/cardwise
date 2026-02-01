# Credit Card Data Crawler

A Python script for maintaining credit card sign-up bonus data.

## Setup

1. Create a virtual environment:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```

3. Configure environment variables:
   ```bash
   cp .env.example .env
   # Edit .env with your Supabase credentials
   ```

## Usage

### Check for SUB Changes
```bash
python crawler.py --check
```
This generates a report of all cards and their current SUB status.

### Export Data to JSON
```bash
python crawler.py --export
```
Exports current database to `cards_data.json` for backup or review.

### Update a Card's SUB
```bash
python crawler.py --update --card "Chase Sapphire Preferred" --sub 75000 --highest
```
- `--card`: Card name (must match exactly)
- `--sub`: New SUB value in dollars (e.g., 75000 for $750)
- `--highest`: Optional flag to mark as all-time high

## Data Sources

The crawler is designed to support manual data entry with optional automated checks.
Recommended sources for SUB information:

- [Doctor of Credit](https://www.doctorofcredit.com/)
- [The Points Guy](https://thepointsguy.com/)
- [US Credit Card Guide](https://www.uscreditcardguide.com/)
- Official bank websites

## Best Practices

1. **Manual Review**: Always manually verify SUB changes before updating
2. **Backup Data**: Export data regularly with `--export`
3. **Track Sources**: Keep notes on where you found SUB information
4. **Update Regularly**: Check for changes weekly or when major offers are announced

## Data Accuracy

This tool helps manage data but relies on:
- Manual entry for accuracy
- Human review before database updates
- Regular checks against official sources

Never automatically update the production database without review.
