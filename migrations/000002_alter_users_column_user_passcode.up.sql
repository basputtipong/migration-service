-- Up Migration: Add user_passcode column

ALTER TABLE users
ADD COLUMN user_passcode VARCHAR(255) DEFAULT NULL;