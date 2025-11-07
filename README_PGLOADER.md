# Using pgloader to Import MySQL Dump to PostgreSQL

## Installation

Run the installation script:
```bash
./install_pgloader.sh
```

Or install manually:
```bash
# Ubuntu/Debian
sudo apt-get install pgloader

# Or via snap
sudo snap install pgloader

# Or build from source (see pgloader GitHub)
```

## Usage

### Option 1: Load from MySQL dump file (Recommended)

This loads directly from the SQL dump file:

```bash
pgloader load_mysql_from_dump.load
```

### Option 2: Load from MySQL server

If you have MySQL server running, you can load directly:

```bash
pgloader load_mysql.load
```

**Note:** Update the connection strings in the `.load` files:
- MySQL: `mysql://user:password@host:port/database`
- PostgreSQL: `postgresql://user:password@host:port/database`

## What the load file does:

1. **Creates tables** - Automatically converts MySQL schema to PostgreSQL
2. **Renames tables** - `cuser` → `users`
3. **Converts data types**:
   - `datetime` → `timestamptz`
   - `tinyint` → `smallint`
   - `bit(1)` → `boolean`
   - `enum` → `text`
4. **Creates indexes** - Preserves MySQL indexes
5. **Resets sequences** - Sets PostgreSQL sequences correctly

## Troubleshooting

If you get connection errors:
- Make sure PostgreSQL is running: `sudo systemctl status postgresql`
- Check connection string in the `.load` file
- Verify database exists: `psql -U postgres -l`

If you get permission errors:
- Make sure the PostgreSQL user has CREATE DATABASE permission
- Or create the database first: `createdb -U postgres wayzaway`
