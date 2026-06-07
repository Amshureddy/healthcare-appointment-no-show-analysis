-- Healthcare Patient Appointment No-Show Analysis
-- SQL analysis queries

-- 1. Overall no-show rate
SELECT 
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    SUM(show_up_flag) AS total_show_ups,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments;

-- 2. No-show rate by age group
SELECT 
    age_group,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY age_group
ORDER BY no_show_rate_pct DESC;

-- 3. No-show rate by waiting period
SELECT 
    waiting_period,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY waiting_period
ORDER BY no_show_rate_pct DESC;

-- 4. No-show rate by SMS reminder status
SELECT 
    CASE WHEN sms_received = 1 THEN 'SMS Received' ELSE 'No SMS' END AS sms_status,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY sms_status
ORDER BY no_show_rate_pct DESC;

-- 5. No-show rate by appointment weekday
SELECT 
    appointment_weekday,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY appointment_weekday
ORDER BY no_show_rate_pct DESC;

-- 6. Top 10 neighbourhoods by no-show rate
-- Minimum 100 appointments avoids ranking tiny sample sizes too highly.
SELECT 
    neighbourhood,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY neighbourhood
HAVING COUNT(*) >= 100
ORDER BY no_show_rate_pct DESC
LIMIT 10;

-- 7. No-show rate by gender
SELECT 
    gender,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY gender
ORDER BY no_show_rate_pct DESC;

-- 8. No-show rate by scholarship status
SELECT 
    CASE WHEN scholarship = 1 THEN 'Scholarship' ELSE 'No Scholarship' END AS scholarship_status,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY scholarship_status
ORDER BY no_show_rate_pct DESC;

-- 9. No-show rate by health condition
SELECT 'Hypertension' AS condition_name, hypertension AS condition_flag,
       COUNT(*) AS total_appointments,
       SUM(no_show_flag) AS total_no_shows,
       ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY hypertension

UNION ALL

SELECT 'Diabetes' AS condition_name, diabetes AS condition_flag,
       COUNT(*) AS total_appointments,
       SUM(no_show_flag) AS total_no_shows,
       ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY diabetes

UNION ALL

SELECT 'Alcoholism' AS condition_name, alcoholism AS condition_flag,
       COUNT(*) AS total_appointments,
       SUM(no_show_flag) AS total_no_shows,
       ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY alcoholism

ORDER BY condition_name, condition_flag;

-- 10. Monthly appointment and no-show trend
SELECT 
    appointment_month,
    COUNT(*) AS total_appointments,
    SUM(no_show_flag) AS total_no_shows,
    ROUND(SUM(no_show_flag) * 100.0 / COUNT(*), 2) AS no_show_rate_pct
FROM appointments
GROUP BY appointment_month
ORDER BY appointment_month;
