BEGIN;

ALTER TABLE tag DROP COLUMN ref_count;
ALTER TABLE url DROP COLUMN ref_count;

COMMIT;