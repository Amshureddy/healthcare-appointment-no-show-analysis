# Healthcare Patient Appointment No-Show Analysis

## Project Overview

This project analyzes healthcare appointment records to identify patterns linked with patient no-shows. The goal is to help healthcare administrators understand which patient groups and appointment factors are associated with missed appointments so they can improve scheduling, reminders, and follow-up planning.

I used Python to clean the data, SQL to explore the main no-show patterns, and Power BI to build the final dashboard.

## Business Problem

Healthcare clinics lose appointment capacity, staff time, and potential revenue when patients miss scheduled appointments. This project answers the question:

**Which patient and appointment factors are associated with higher no-show rates?**

I focused on understanding no-show trends by age group, waiting period, SMS reminder status, appointment weekday, and neighborhood..

## Dataset

The dataset contains medical appointment records with fields such as patient ID, appointment ID, gender, scheduled date, appointment date, age, neighborhood, SMS reminder status, medical conditions, and no-show status.

After cleaning, the analysis-ready dataset contains:

| Metric | Value |
|---|---:|
| Valid appointment records | 110,521 |
| Total no-shows | 22,319 |
| Overall no-show rate | 20.19% |
| Overall show-up rate | 79.81% |

## Tools Used

- Python
- pandas
- SQL
- Power BI
- Excel/CSV
- GitHub

## Data Cleaning Steps

The raw dataset was cleaned and prepared before dashboard development. Main cleaning steps included:

1. Standardized column names into readable snake_case format.
2. Converted scheduled and appointment date columns into date/time fields.
3. Removed invalid age records.
4. Removed records with negative waiting days.
5. Created `waiting_days` to measure the gap between scheduling date and appointment date.
6. Created `waiting_period` groups such as 1-7 days, 8-30 days, and 30+ days.
7. Created `age_group` categories such as Child, Teen, Young Adult, Adult, and Senior.
8. Converted no-show status into numeric flags for rate calculations.
9. Exported an analysis-ready CSV for Power BI reporting.

## Dashboard Overview

The Power BI dashboard includes:

- KPI card for total appointments
- KPI card for total no-shows
- KPI card for no-show rate
- Donut chart for show vs no-show distribution
- Bar chart for no-show rate by age group
- Bar chart for no-show rate by waiting period
- Bar chart for no-show rate by SMS reminder
- Bar chart for no-show rate by appointment weekday
- Bar chart for no-show rate by neighborhood
- Interactive slicers for gender, age group, and SMS received

## Dashboard Screenshot

![Healthcare Patient Appointment No-Show Dashboard](dashboard_screenshot.png)
## Key Insights

1. The cleaned dataset contains 110,521 valid appointment records.
2. Around 22,319 appointments were missed, resulting in an overall no-show rate of about 20.19%.
3. Teen and young adult patients show higher no-show rates compared with senior patients.
4. Longer waiting periods are associated with higher no-show rates.
5. Patients who received SMS reminders show a higher observed no-show rate. This should not be interpreted as SMS causing no-shows because reminders may have been sent more often to higher-risk patients.
6. Appointment weekday shows some variation, with Saturday shows a higher observed no-show rate compared with other appointment weekdays..
7. Neighborhood-level results should be interpreted carefully because smaller appointment counts can create unusually high percentages.

## Business Recommendations

1. Prioritize follow-up reminders for patients with long waiting periods.
2. Create targeted reminder strategies for teen and young adult patients.
3. Review SMS reminder strategy and compare no-show rates after controlling for waiting period and patient risk factors.
4. Monitor appointment scheduling patterns by weekday to improve clinic capacity planning.
5. Use neighborhood-level analysis only after checking appointment volume to avoid misleading conclusions from small sample sizes.

## Project Files


| File                                         | Description                                             |
| -------------------------------------------- | ------------------------------------------------------- |
| `README.md`                                  | Project summary, process, insights, and recommendations |
| `dashboard_screenshot.png`                   | Screenshot of the final Power BI dashboard              |
| `data_cleaning_script.py`                    | Python script used to clean and prepare the dataset     |
| `create_tables.sql`                          | SQL script for creating the appointment table           |
| `data_analysis_queries.sql`                  | SQL queries used to analyze no-show patterns            |
| `data_dictionary.md`                         | Explanation of important columns used in the project    |
| `power_bi_dax_measures.txt`                  | DAX measures used for dashboard calculations            |
| `insights.md`                                | Detailed insights from the analysis                     |
| `healthcare_appointments_analysis_ready.csv` | Cleaned dataset used for analysis and dashboarding      |

## What I Learned

Through this project, I practiced cleaning a real-world healthcare dataset, creating useful derived columns, writing SQL queries for analysis, and building an interactive Power BI dashboard. I also learned how no-show rates can be affected by factors such as patient age group, waiting period, appointment weekday, and SMS reminder status.

## Project Outcome

The final dashboard helps identify patterns in missed appointments and provides simple business recommendations that a clinic could use to improve appointment planning and reminder strategies.
