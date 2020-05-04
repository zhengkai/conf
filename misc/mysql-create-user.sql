SET GLOBAL validate_password.length = 6;
SET GLOBAL validate_password.number_count = 0;
SET GLOBAL validate_password.mixed_case_count = 0;
SET GLOBAL validate_password.special_char_count = 0;
FLUSH PRIVILEGES;
CREATE USER 'plutus'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON *.* TO 'plutus'@'localhost';
GRANT GRANT OPTION ON *.* TO 'plutus'@'localhost';
