-- Clean up invalid reaction types from event_reaction table
-- This removes any rows with invalid or null reaction_type values

DELETE FROM event_reaction 
WHERE reaction_type IS NULL 
   OR reaction_type NOT IN ('like', 'unlike', 'heart', 'laugh', 'sad', 'angry');

-- View invalid reactions before deleting (uncomment to check)
-- SELECT * FROM event_reaction 
-- WHERE reaction_type IS NULL 
--    OR reaction_type NOT IN ('like', 'unlike', 'heart', 'laugh', 'sad', 'angry');

