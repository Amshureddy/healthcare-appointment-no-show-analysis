-- Healthcare Patient Appointment No-Show Analysis
-- Table creation script for PostgreSQL.
-- Import the file data/cleaned/healthcare_appointments_analysis_ready.csv into this table.

DROP TABLE IF EXISTS appointments;

CREATE TABLE appointments (
    patient_id VARCHAR(30),
    appointment_id VARCHAR(30) PRIMARY KEY,
    gender VARCHAR(1),
    age INTEGER,
    age_group VARCHAR(30),
    neighbourhood VARCHAR(100),
    scheduled_datetime TIMESTAMP,
    appointment_datetime TIMESTAMP,
    scheduled_date DATE,
    appointment_date DATE,
    scheduled_weekday VARCHAR(20),
    appointment_weekday VARCHAR(20),
    scheduled_month VARCHAR(7),
    appointment_month VARCHAR(7),
    waiting_days INTEGER,
    waiting_period VARCHAR(20),
    scholarship INTEGER,
    hypertension INTEGER,
    diabetes INTEGER,
    alcoholism INTEGER,
    handicap INTEGER,
    sms_received INTEGER,
    no_show VARCHAR(10),
    no_show_flag INTEGER,
    show_up_flag INTEGER,
    attendance_status VARCHAR(20)
);

-- Optional PostgreSQL import command.
-- Update the local file path before running.
-- COPY appointments
-- FROM '/your/local/path/healthcare_appointments_analysis_ready.csv'
-- DELIMITER ','
-- CSV HEADER;
