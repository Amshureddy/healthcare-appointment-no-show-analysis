import pandas as pd
from pathlib import Path

RAW_PATH = Path("../data/raw/KaggleV2-May-2016.csv")
CLEANED_PATH = Path("../data/cleaned/healthcare_appointments_cleaned.csv")
ANALYSIS_READY_PATH = Path("../data/cleaned/healthcare_appointments_analysis_ready.csv")

df = pd.read_csv(RAW_PATH)

rename_map = {
    "PatientId": "patient_id",
    "AppointmentID": "appointment_id",
    "Gender": "gender",
    "ScheduledDay": "scheduled_day",
    "AppointmentDay": "appointment_day",
    "Age": "age",
    "Neighbourhood": "neighbourhood",
    "Scholarship": "scholarship",
    "Hipertension": "hypertension",
    "Diabetes": "diabetes",
    "Alcoholism": "alcoholism",
    "Handcap": "handicap",
    "SMS_received": "sms_received",
    "No-show": "no_show"
}

clean = df.rename(columns=rename_map).copy()

clean["scheduled_day"] = pd.to_datetime(clean["scheduled_day"], errors="coerce", utc=True)
clean["appointment_day"] = pd.to_datetime(clean["appointment_day"], errors="coerce", utc=True)

# Convert identifiers to strings so Excel/Power BI does not display patient IDs in scientific notation.
clean["patient_id"] = clean["patient_id"].round(0).astype("int64").astype(str)
clean["appointment_id"] = clean["appointment_id"].astype("int64").astype(str)

# Remove invalid age records. Age 0 is kept because it can represent infants.
clean = clean[clean["age"] >= 0].copy()

clean["scheduled_date"] = clean["scheduled_day"].dt.date
clean["appointment_date"] = clean["appointment_day"].dt.date
clean["scheduled_datetime"] = clean["scheduled_day"].dt.strftime("%Y-%m-%d %H:%M:%S")
clean["appointment_datetime"] = clean["appointment_day"].dt.strftime("%Y-%m-%d %H:%M:%S")

clean["waiting_days"] = (
    pd.to_datetime(clean["appointment_date"]) - pd.to_datetime(clean["scheduled_date"])
).dt.days

clean["no_show_flag"] = clean["no_show"].map({"Yes": 1, "No": 0}).astype(int)
clean["show_up_flag"] = 1 - clean["no_show_flag"]
clean["attendance_status"] = clean["no_show_flag"].map({1: "No Show", 0: "Showed Up"})

for col in ["scholarship", "hypertension", "diabetes", "alcoholism", "handicap", "sms_received"]:
    clean[col] = clean[col].astype(int)

age_bins = [-1, 12, 19, 35, 59, 200]
age_labels = ["Child (0-12)", "Teen (13-19)", "Young Adult (20-35)", "Adult (36-59)", "Senior (60+)"]
clean["age_group"] = pd.cut(clean["age"], bins=age_bins, labels=age_labels)

def waiting_period(days):
    if pd.isna(days):
        return "Unknown"
    if days < 0:
        return "Invalid"
    if days == 0:
        return "Same Day"
    if days <= 7:
        return "1-7 Days"
    if days <= 30:
        return "8-30 Days"
    return "30+ Days"

clean["waiting_period"] = clean["waiting_days"].apply(waiting_period)
clean["appointment_weekday"] = pd.to_datetime(clean["appointment_date"]).dt.day_name()
clean["scheduled_weekday"] = pd.to_datetime(clean["scheduled_date"]).dt.day_name()
clean["appointment_month"] = pd.to_datetime(clean["appointment_date"]).dt.strftime("%Y-%m")
clean["scheduled_month"] = pd.to_datetime(clean["scheduled_date"]).dt.strftime("%Y-%m")
clean["neighbourhood"] = clean["neighbourhood"].str.title()

columns = [
    "patient_id", "appointment_id", "gender", "age", "age_group", "neighbourhood",
    "scheduled_datetime", "appointment_datetime", "scheduled_date", "appointment_date",
    "scheduled_weekday", "appointment_weekday", "scheduled_month", "appointment_month",
    "waiting_days", "waiting_period", "scholarship", "hypertension", "diabetes",
    "alcoholism", "handicap", "sms_received", "no_show", "no_show_flag",
    "show_up_flag", "attendance_status"
]

clean = clean[columns]
clean.to_csv(CLEANED_PATH, index=False)

# Analysis-ready file removes negative waiting-day records because appointment date before scheduled date is not valid.
analysis_ready = clean[clean["waiting_days"] >= 0].copy()
analysis_ready.to_csv(ANALYSIS_READY_PATH, index=False)

print("Raw rows:", len(df))
print("Cleaned rows:", len(clean))
print("Analysis-ready rows:", len(analysis_ready))
print("Overall no-show rate:", round(analysis_ready["no_show_flag"].mean() * 100, 2), "%")
