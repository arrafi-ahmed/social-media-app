-- Migration: Update 'wow' reaction type to 'unlike'
-- This updates all existing 'wow' reactions in the event_reaction table to 'unlike'
-- Also updates 'happy' reactions to 'unlike' if any exist

UPDATE event_reaction 
SET reaction_type = 'unlike' 
WHERE reaction_type = 'wow' OR reaction_type = 'happy';

