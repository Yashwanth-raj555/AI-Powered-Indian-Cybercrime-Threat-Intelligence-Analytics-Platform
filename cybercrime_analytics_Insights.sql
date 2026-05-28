CREATE DATABASE cybercrime_analytics_db
USE cybercrime_analytics_db

SELECT * FROM cyber_attacks

-- Q1. What is the total number of cybercrime cases reported in India?

SELECT COUNT(*) AS total_cases
FROM cyber_attacks;

-- Q2. Executive Summary of Indian Cybercrime Cases
SELECT
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    AVG(amount_lost_inr) AS average_loss,
    MAX(amount_lost_inr) AS highest_loss,
    MIN(amount_lost_inr) AS minimum_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks;

-- Q3. Yearly Cybercrime Trend & Financial Growth Analysis
SELECT
    year,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks
GROUP BY year
ORDER BY year;

-- Q4. Cyber Attack Type Analysis with Risk Evaluation
SELECT
    incident_type,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    MAX(amount_lost_inr) AS highest_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks
GROUP BY incident_type
ORDER BY total_financial_loss DESC;

-- Q5. Indian City-Level Cybercrime Risk Analysis
SELECT
    city,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks
GROUP BY city
ORDER BY total_financial_loss DESC;

-- Q6. Sector-Wise Cybercrime Threat Intelligence Analysis
SELECT
    category,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks
GROUP BY category 
ORDER BY total_financial_loss DESC;

-- Q7. High-Risk Cyber Attack Detection Analysis
SELECT
    incident_type,
    city,
    category,
    COUNT(*) AS high_risk_cases,
    SUM(amount_lost_inr) AS total_high_risk_loss
FROM cyber_attacks
WHERE is_high_value_attack = 1
GROUP BY incident_type, city, category
ORDER BY total_high_risk_loss DESC;

-- Q8. Monthly Period-Based Cybercrime Pattern Analysis
SELECT
    day_range,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss
FROM cyber_attacks
GROUP BY day_range
ORDER BY total_financial_loss DESC;

-- Q9. Top 10 Highest Financial Loss Cybercrime Incidents
SELECT TOP 10
    year,
    city,
    incident_type,
    category,
    amount_lost_inr
FROM cyber_attacks
ORDER BY amount_lost_inr DESC;

-- Q11. Top Cybercrime Affected Indian Cities Ranking
SELECT
    city,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    DENSE_RANK() OVER (
        ORDER BY SUM(amount_lost_inr) DESC
    ) AS city_risk_rank
FROM cyber_attacks
GROUP BY city;

-- Q12. Year-over-Year Financial Loss Growth Analysis
SELECT
    year,
    SUM(amount_lost_inr) AS yearly_loss,
    LAG(SUM(amount_lost_inr))
    OVER (ORDER BY year) AS previous_year_loss
FROM cyber_attacks
GROUP BY year
ORDER BY year;

-- Q13. Comprehensive Threat Intelligence Summary Report
SELECT
    year,
    city,
    incident_type,
    category,
    amount_lost_category,
    COUNT(*) AS total_cases,
    SUM(amount_lost_inr) AS total_financial_loss,
    SUM(is_high_value_attack) AS high_risk_cases
FROM cyber_attacks
GROUP BY
    year,
    city,
    incident_type,
    category,
    amount_lost_category
ORDER BY total_financial_loss DESC;