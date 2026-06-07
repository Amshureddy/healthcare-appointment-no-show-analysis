# Data Dictionary

| Column | Meaning |
|---|---|
| patient_id | Unique patient identifier from the original dataset |
| appointment_id | Unique appointment identifier |
| gender | Patient gender |
| age | Patient age |
| age_group | Grouped age category for dashboard analysis |
| neighbourhood | Appointment clinic neighbourhood/location |
| scheduled_datetime | Date and time when the appointment was scheduled |
| appointment_datetime | Actual appointment date and time from source |
| scheduled_date | Scheduled date only |
| appointment_date | Appointment date only |
| scheduled_weekday | Weekday when appointment was scheduled |
| appointment_weekday | Weekday of the actual appointment |
| scheduled_month | Scheduled month in YYYY-MM format |
| appointment_month | Appointment month in YYYY-MM format |
| waiting_days | Calendar days between scheduled_date and appointment_date |
| waiting_period | Grouped waiting time category |
| scholarship | 1 if patient was enrolled in the scholarship/welfare program, otherwise 0 |
| hypertension | 1 if patient had hypertension, otherwise 0 |
| diabetes | 1 if patient had diabetes, otherwise 0 |
| alcoholism | 1 if patient had alcoholism flag, otherwise 0 |
| handicap | Handicap category from the original dataset |
| sms_received | 1 if patient received SMS reminder, otherwise 0 |
| no_show | Original target column: Yes means the patient did not show up, No means they showed up |
| no_show_flag | 1 if patient missed appointment, 0 if patient showed up |
| show_up_flag | 1 if patient showed up, 0 if patient missed appointment |
| attendance_status | Readable appointment outcome: Showed Up or No Show |

## Data Quality Notes

- Removed 1 row with invalid negative age.
- Created an analysis-ready dataset that also removes 5 rows where appointment date was earlier than scheduled date.
- Kept age 0 because it can represent infants.
- Converted patient_id and appointment_id to text to avoid scientific notation issues in Excel and Power BI.
