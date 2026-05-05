USE portfolio_db;
UPDATE users SET password_hash='$2a$12$4qZYFNNgWb/cEeJ98U/4cO5HWTmDk4BVNfri85YhVxJAnBbLMJdUi' WHERE username='rishi';
SELECT username,password_hash FROM users WHERE username='rishi';
