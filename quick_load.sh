#!/bin/bash
# Quick script to load MySQL dump to PostgreSQL using pgloader

set -e

DB_NAME="${1:-wayzaway}"
PG_USER="${2:-postgres}"
PG_PASS="${3:-postgres}"
MYSQL_USER="${4:-root}"
MYSQL_PASS="${5:-password}"

echo "Loading MySQL dump to PostgreSQL..."
echo "Database: $DB_NAME"
echo "PostgreSQL: $PG_USER@localhost"
echo "MySQL: $MYSQL_USER@localhost"
echo ""

# Check if pgloader is installed
if ! command -v pgloader &> /dev/null; then
    echo "Error: pgloader is not installed"
    echo "Run: ./install_pgloader.sh"
    exit 1
fi

# Check if PostgreSQL is running
if ! pg_isready -U $PG_USER &> /dev/null; then
    echo "Error: PostgreSQL is not running"
    exit 1
fi

# Create database if it doesn't exist
psql -U $PG_USER -tc "SELECT 1 FROM pg_database WHERE datname = '$DB_NAME'" | grep -q 1 || \
    psql -U $PG_USER -c "CREATE DATABASE $DB_NAME"

# Method 1: If MySQL server is running, load directly
if mysql -u$MYSQL_USER -p$MYSQL_PASS -e "USE wayzaway;" &> /dev/null; then
    echo "MySQL server detected. Loading directly..."
    sed "s|postgresql://.*|postgresql://$PG_USER:$PG_PASS@localhost:5432/$DB_NAME|" \
        load_mysql.load | \
    sed "s|mysql://.*|mysql://$MYSQL_USER:$MYSQL_PASS@localhost/wayzaway|" | \
    pgloader -
else
    echo "MySQL server not running. Please:"
    echo "1. Import the dump into MySQL first:"
    echo "   mysql -u$MYSQL_USER -p$MYSQL_PASS wayzaway < emmanuel_prod-mysql-dump.sql"
    echo ""
    echo "2. Then run this script again"
    exit 1
fi

echo ""
echo "✓ Load complete!"
