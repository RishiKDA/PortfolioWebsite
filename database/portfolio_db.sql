-- ============================================================
-- portfolio_db.sql — Complete Database for Rishi Kedia Portfolio
-- ============================================================

CREATE DATABASE IF NOT EXISTS portfolio_db;
USE portfolio_db;

-- ─────────────────────────────────────────────
-- TABLE: users (admin authentication)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ─────────────────────────────────────────────
-- TABLE: about (profile info)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS about (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    objective TEXT,
    github_url VARCHAR(200),
    linkedin_url VARCHAR(200),
    languages_spoken VARCHAR(200),
    soft_skills TEXT
);

-- ─────────────────────────────────────────────
-- TABLE: skills (technical skills)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS skills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,  -- 'language', 'library', 'tool'
    proficiency INT DEFAULT 80       -- percentage 0–100
);

-- ─────────────────────────────────────────────
-- TABLE: projects
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    tech_stack VARCHAR(300),
    github_url VARCHAR(300),
    live_url VARCHAR(300),
    image_url VARCHAR(300),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ─────────────────────────────────────────────
-- TABLE: education
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS education (
    id INT AUTO_INCREMENT PRIMARY KEY,
    degree VARCHAR(200),
    institution VARCHAR(200),
    start_year VARCHAR(10),
    end_year VARCHAR(10),
    cgpa VARCHAR(20),
    description TEXT
);

-- ─────────────────────────────────────────────
-- TABLE: certifications
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS certifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200),
    issuer VARCHAR(200),
    year VARCHAR(10)
);

-- ─────────────────────────────────────────────
-- TABLE: experience
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS experience (
    id INT AUTO_INCREMENT PRIMARY KEY,
    role VARCHAR(200),
    company VARCHAR(200),
    duration VARCHAR(100),
    description TEXT
);

-- ─────────────────────────────────────────────
-- TABLE: messages (contact form)
-- ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    sender_name VARCHAR(100),
    sender_email VARCHAR(100),
    subject VARCHAR(200),
    message TEXT,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_read BOOLEAN DEFAULT FALSE
);

-- ============================================================
-- SEED DATA — Rishi Kedia
-- ============================================================

-- Admin user (password: Admin@1234 — BCrypt hash)
INSERT INTO users (username, email, password_hash) VALUES
('rishi', 'kedia.rishi14@gmail.com',
 '$2a$12$K5J5fvCxIQUJf1z2pT7Y4OVH0O5jG3Xk8lPyRwNq6EsBdYtMaZuWa');

-- About
INSERT INTO about (full_name, phone, email, objective, github_url, linkedin_url, languages_spoken, soft_skills)
VALUES (
    'Rishi Kedia',
    '+91 8521514448',
    'kedia.rishi14@gmail.com',
    'Aspiring Data Engineer and Data Analyst with strong proficiency in Java and a solid foundation in Object-Oriented Programming and Data Structures and Algorithms. Possesses working knowledge of Python and applies strong logical thinking and problem-solving skills to projects. Familiar with web technologies including HTML, CSS, and JavaScript, and has hands-on exposure to machine learning concepts through academic work.',
    'https://github.com/RishiKDA',
    'https://linkedin.com/in/rishi-kedia',
    'English, Hindi',
    'Communication,Logical Reasoning,Problem Solving,Teamwork,Time Management,Attention to Detail,Fast Learner'
);

-- Skills — Languages
INSERT INTO skills (skill_name, category, proficiency) VALUES
('Java',        'language', 90),
('C++',         'language', 75),
('Python',      'language', 80),
('HTML/CSS',    'language', 78),
('JavaScript',  'language', 72);

-- Skills — Libraries
INSERT INTO skills (skill_name, category, proficiency) VALUES
('Pandas',      'library', 82),
('NumPy',       'library', 80),
('Matplotlib',  'library', 75),
('Scikit-learn','library', 78);

-- Skills — Tools
INSERT INTO skills (skill_name, category, proficiency) VALUES
('MS Excel',    'tool', 85),
('VS Code',     'tool', 90),
('Git',         'tool', 82),
('GitHub',      'tool', 85),
('MySQL',       'tool', 78);

-- Projects
INSERT INTO projects (title, description, tech_stack, github_url)
VALUES (
    'Heart Disease Prediction Using Logistic Regression',
    'Built a machine learning model using Logistic Regression to predict heart disease. Performed comprehensive data preprocessing, feature selection, and exploratory data analysis. Applied Pandas, NumPy, and Scikit-learn for model development. Evaluated model performance using accuracy, precision, recall, and F1-score metrics.',
    'Python, Pandas, NumPy, Scikit-learn, Matplotlib, Logistic Regression',
    'https://github.com/RishiKDA/Heart-Disease-Prediction-Using-Logistic-Regression'
);

-- Education
INSERT INTO education (degree, institution, start_year, end_year, cgpa, description)
VALUES (
    'B.Tech in Computer Science Engineering',
    'Techno India University',
    '2023',
    'Present',
    '7.81',
    'Pursuing Bachelor of Technology in Computer Science Engineering with focus on Data Structures, Algorithms, Object-Oriented Programming, Database Management, and Machine Learning.'
);

-- Certifications
INSERT INTO certifications (title, issuer, year) VALUES
('IBM ML & AI Virtual Internship Certificate',           'IBM Skills Network',  '2026'),
('Intelligent Automation Internship Certificate',        'EduSkills',           '2023'),
('e1133 Participation Certificate',                      'Various',             '2024'),
('TCS Participation Certificate',                        'TCS',                 '2024');

-- Experience
INSERT INTO experience (role, company, duration, description)
VALUES (
    'AI & Machine Learning Virtual Intern',
    'IBM Skills Network (Remote)',
    'Sep 2025 – Nov 2025',
    'Worked on real-world ML and AI projects under IBM Skills Network. Built a heart disease prediction model using Logistic Regression. Used Python for data analysis and visualization. Applied concepts of Machine Learning, Deep Learning, and Prompt Engineering. Performed Exploratory Data Analysis (EDA) and model evaluation.'
);

-- ============================================================
-- End of portfolio_db.sql
-- ============================================================
