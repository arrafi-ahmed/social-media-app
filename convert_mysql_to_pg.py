#!/usr/bin/env python3
"""
Convert MySQL dump file to PostgreSQL format
"""
import re
import sys
from datetime import datetime

def convert_mysql_to_pg(content):
    """Convert MySQL dump SQL to PostgreSQL format"""
    
    indexes = []  # Store indexes to create after tables
    
    # Remove MySQL-specific header comments and SET statements
    content = re.sub(r'/\*![\d]+\s+[^*]*\*+//', '', content)
    content = re.sub(r'/\*!40101 SET[^;]*;', '', content)
    content = re.sub(r'/\*!50503 SET[^;]*;', '', content)
    content = re.sub(r'/\*!40103 SET[^;]*;', '', content)
    content = re.sub(r'/\*!40014 SET[^;]*;', '', content)
    content = re.sub(r'/\*!40111 SET[^;]*;', '', content)
    content = re.sub(r'/[*]40101 SET character_set_client[^;]*;/', '', content)
    content = re.sub(r'/[*]50503 SET character_set_client[^;]*;/', '', content)
    
    # Remove MySQL-specific commands (more aggressive)
    content = re.sub(r'LOCK TABLES[^;]*;', '', content)
    content = re.sub(r'UNLOCK TABLES;', '', content)
    content = re.sub(r'/[*]40000[^*]*\*+/', '', content)
    content = re.sub(r'/[*]![\d]+[^*]*\*+/', '', content)
    content = re.sub(r'SET @saved_cs_client[^;]*;', '', content)
    content = re.sub(r'SET @OLD_[^;]*;', '', content)
    content = re.sub(r'SET character_set_client[^;]*;', '', content)
    content = re.sub(r'SET @@[^;]*;', '', content)
    content = re.sub(r'SET TIME_ZONE[^;]*;', '', content)
    content = re.sub(r'/\*[\s\S]*?\*/', '', content)  # Remove all /* comments */
    
    # Convert backticks to double quotes
    content = re.sub(r'`([^`]+)`', r'"\1"', content)
    
    # Remove ENGINE, CHARSET, and COLLATE clauses
    content = re.sub(r'\s+ENGINE=InnoDB[^;]*', '', content)
    content = re.sub(r'\s+AUTO_INCREMENT=\d+', '', content)
    content = re.sub(r'\s+CHARACTER SET[^,\s)]*', '', content)
    content = re.sub(r'\s+COLLATE[^,\s)]*', '', content)
    content = re.sub(r'\s+DEFAULT CHARSET=[^;]*', '', content)
    
    # Convert AUTO_INCREMENT to SERIAL
    # Pattern: column_name int NOT NULL AUTO_INCREMENT -> column_name SERIAL
    # Handle quoted and unquoted column names with flexible whitespace
    # Match: "id" int NOT NULL AUTO_INCREMENT or id int NOT NULL AUTO_INCREMENT
    pattern1 = r'("?\w+"?)\s+int\s+NOT\s+NULL\s+AUTO_INCREMENT'
    content = re.sub(pattern1, r'\1 SERIAL', content, flags=re.IGNORECASE)
    # Handle AUTO_INCREMENT before NOT NULL
    pattern2 = r'("?\w+"?)\s+int\s+AUTO_INCREMENT\s+NOT\s+NULL'
    content = re.sub(pattern2, r'\1 SERIAL', content, flags=re.IGNORECASE)
    # Handle just AUTO_INCREMENT (less common but possible)
    pattern3 = r'("?\w+"?)\s+int\s+AUTO_INCREMENT'
    content = re.sub(pattern3, r'\1 SERIAL', content, flags=re.IGNORECASE)
    
    # Convert data types
    content = re.sub(r'\btinyint\(1\)', 'BOOLEAN', content, flags=re.IGNORECASE)
    content = re.sub(r'\btinyint\b', 'SMALLINT', content, flags=re.IGNORECASE)
    content = re.sub(r'\bmediumint\b', 'INTEGER', content, flags=re.IGNORECASE)
    content = re.sub(r'\bdatetime\b', 'TIMESTAMP', content, flags=re.IGNORECASE)
    
    # Clean up TEXT columns with COLLATE
    content = re.sub(r'\btext\s+COLLATE[^,\s)]*', 'TEXT', content, flags=re.IGNORECASE)
    content = re.sub(r'\bvarchar\([^)]+\)\s+COLLATE[^,\s)]*', lambda m: m.group(0).split(' COLLATE')[0], content, flags=re.IGNORECASE)
    
    # Convert table name cuser to users
    content = re.sub(r'"cuser"', '"users"', content)
    content = re.sub(r'REFERENCES\s+"cuser"', 'REFERENCES "users"', content, flags=re.IGNORECASE)
    
    # Convert KEY statements to CREATE INDEX (PostgreSQL doesn't support KEY in CREATE TABLE)
    # We'll need to extract these and create separate CREATE INDEX statements
    # For now, remove KEY from CREATE TABLE (we'll handle indexes separately if needed)
    # Actually, PostgreSQL uses CREATE INDEX separately, so we should remove KEY from table definitions
    # But we'll leave UNIQUE KEY for now as it's part of constraint
    # Pattern: KEY "name" ("column") -> will be removed from CREATE TABLE, needs separate CREATE INDEX
    # For simplicity, remove KEY statements from CREATE TABLE for now
    # They can be added back as CREATE INDEX statements if needed
    
    # Remove trailing MySQL comment syntax
    content = re.sub(r'--\s*$', '', content, flags=re.MULTILINE)
    
    # Extract KEY statements before removing them (PostgreSQL uses CREATE INDEX separately)
    # First, find all KEY definitions with their table context
    key_pattern = r'CREATE TABLE\s+"?(\w+)"?[^;]+?,\s*KEY\s+"?(\w+)"?\s*\("?(\w+)"?\)'
    key_matches = re.finditer(key_pattern, content, flags=re.IGNORECASE | re.DOTALL)
    for match in key_matches:
        table_name = match.group(1)
        key_name = match.group(2)
        column = match.group(3)
        indexes.append(f'CREATE INDEX IF NOT EXISTS "{key_name}" ON "{table_name}" ("{column}");')
    
    # Now remove KEY statements from CREATE TABLE
    key_pattern_remove = r',\s*KEY\s+"?(\w+)"?\s*\("?(\w+)"?\)'
    content = re.sub(key_pattern_remove, '', content, flags=re.IGNORECASE)
    
    # Handle UNIQUE KEY - convert to UNIQUE constraint
    def extract_unique_key(match):
        key_name = match.group(1)
        column = match.group(2)
        # Convert to UNIQUE constraint
        return f',\n  UNIQUE ("{column}")'
    
    unique_key_pattern = r',\s*UNIQUE\s+KEY\s+"?(\w+)"?\s*\("?(\w+)"?\)'
    content = re.sub(unique_key_pattern, extract_unique_key, content, flags=re.IGNORECASE)
    
    # Add index creation statements at the end
    if indexes:
        content += '\n\n-- Indexes\n'
        content += '\n'.join(indexes) + '\n'
    
    # Fix boolean values in INSERT statements (0 -> FALSE, 1 -> TRUE)
    # But be careful not to replace numbers in other contexts
    # This is a simple approach - may need refinement
    
    # Remove empty lines with just whitespace
    content = re.sub(r'^\s*$', '', content, flags=re.MULTILINE)
    
    # Clean up multiple blank lines
    content = re.sub(r'\n\n\n+', '\n\n', content)
    
    return content

def extract_data_only(content):
    """Extract only INSERT statements from the dump (data only, no schema)"""
    # Extract all INSERT statements
    insert_pattern = r'INSERT\s+INTO[^;]+;'
    inserts = re.findall(insert_pattern, content, flags=re.IGNORECASE | re.DOTALL)
    
    if not inserts:
        return ''
    
    # Join all INSERT statements
    result = '\n\n'.join(inserts)
    
    # Convert table name cuser to users in INSERT statements
    result = re.sub(r'INSERT\s+INTO\s+`?cuser`?', 'INSERT INTO "users"', result, flags=re.IGNORECASE)
    
    # Convert backticks to double quotes
    result = re.sub(r'`([^`]+)`', r'"\1"', result)
    
    return result

def main():
    input_file = 'emmanuel_prod-mysql-dump.sql'
    output_file = 'emmanuel_prod-pg-dump.sql'
    
    print(f'Reading {input_file}...')
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            mysql_content = f.read()
    except FileNotFoundError:
        print(f'Error: {input_file} not found!')
        sys.exit(1)
    
    print('Extracting data only (INSERT statements)...')
    data_only = extract_data_only(mysql_content)
    
    # Convert remaining MySQL syntax in INSERT statements
    print('Converting MySQL syntax to PostgreSQL...')
    # For INSERT statements, we mainly need to:
    # 1. Convert table names (cuser -> users)
    # 2. Convert backticks to double quotes (already done in extract_data_only)
    # 3. Remove MySQL-specific syntax
    pg_content = data_only
    
    # Remove any remaining MySQL comments
    pg_content = re.sub(r'/\*[\s\S]*?\*/', '', pg_content)
    pg_content = re.sub(r'/\*![\d]+[^*]*\*+/', '', pg_content)
    
    # Clean up extra whitespace
    pg_content = re.sub(r'\n\n\n+', '\n\n', pg_content)
    
    # Add PostgreSQL header
    header = f'''-- PostgreSQL data dump converted from MySQL
-- Source: {input_file}
-- Converted on: {datetime.now().strftime("%Y-%m-%d %H:%M:%S")}
-- 
-- This file contains ONLY data (INSERT statements)
-- Schema should be created separately using schema-pg.sql
-- 
-- Note: Review and test this dump before using in production
--

'''
    
    final_content = header + pg_content
    
    print(f'Writing {output_file}...')
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write(final_content)
    
    print(f'✓ Conversion complete!')
    print(f'✓ Output file: {output_file}')
    print(f'\nNote: Please review the converted file and test it before importing to PostgreSQL.')
    print(f'You may need to:')
    print(f'  1. Adjust data types if needed')
    print(f'  2. Fix any remaining syntax differences')
    print(f'  3. Update sequences after importing')
    print(f'  4. Verify foreign key constraints')

if __name__ == '__main__':
    main()

