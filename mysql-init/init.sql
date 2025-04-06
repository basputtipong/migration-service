CREATE USER IF NOT EXISTS 'devusr'@'%' IDENTIFIED WITH caching_sha2_password BY 'devpassword';
GRANT ALL PRIVILEGES ON devdb.* TO 'devusr'@'%';
FLUSH PRIVILEGES;
