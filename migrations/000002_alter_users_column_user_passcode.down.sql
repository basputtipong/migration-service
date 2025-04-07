-- Down Migration: Remove user_passcode column

ALTER TABLE users
DROP COLUMN user_passcode;