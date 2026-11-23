
import pandas as pd
import numpy as np
from pathlib import Path

# Reproducible random data
rng = np.random.default_rng(42)

# Project paths
BASE_DIR = Path(__file__).resolve().parent.parent
RAW_DIR = BASE_DIR / "data" / "raw"
RAW_DIR.mkdir(parents=True, exist_ok=True)

# ----------------------------------
# 1. GENERATE STUDENTS
# ----------------------------------

number_of_students = 1000

universities = [
    "INSAT", "TBS", "ENIT", "ESPRIT",
    "FST", "IHEC", "ISAMM", "Other"
]

fields = [
    "Computer Science", "Business",
    "Engineering", "Marketing",
    "Finance", "Design", "Other"
]

academic_years = [
    "1st Year", "2nd Year", "3rd Year",
    "4th Year", "5th Year"
]

students = pd.DataFrame({
    "student_id": [
        f"S{i:04d}" for i in range(1, number_of_students + 1)
    ],
    "university": rng.choice(
        universities, number_of_students,
        p=[0.12, 0.15, 0.12, 0.20, 0.12, 0.10, 0.09, 0.10]
    ),
    "field_of_study": rng.choice(fields, number_of_students),
    "academic_year": rng.choice(academic_years, number_of_students),
    "age": rng.integers(18, 27, number_of_students)
})

# ----------------------------------
# 2. GENERATE EVENTS
# ----------------------------------

number_of_events = 36

categories = [
    "Technology", "Entrepreneurship",
    "Networking", "Workshop",
    "Career Development"
]

events = pd.DataFrame({
    "event_id": [
        f"E{i:03d}" for i in range(1, number_of_events + 1)
    ],
    "event_name": [
        f"{rng.choice(categories)} Event {i}"
        for i in range(1, number_of_events + 1)
    ],
    "category": rng.choice(categories, number_of_events),
    "event_date": pd.date_range(
        start="2026-01-01",
        end="2026-10-31",
        periods=number_of_events
    ),
    "capacity": rng.integers(60, 201, number_of_events),
    "location": rng.choice(
        ["Tunis", "Sousse", "Sfax", "Online"],
        number_of_events
    )
})

# ----------------------------------
# 3. GENERATE REGISTRATIONS
# ----------------------------------

registration_records = []

for _, event in events.iterrows():

    # Number of registrations for this event
    max_registrations = min(int(event["capacity"]), 150)
    min_registrations = min(35, max_registrations)

    number_registered = int(
        rng.integers(min_registrations, max_registrations + 1)
    )

    # Select unique students for this event
    selected_students = rng.choice(
        students["student_id"],
        size=number_registered,
        replace=False
    )

    for student_id in selected_students:

        # Registration must happen before the event
        days_before = int(rng.integers(1, 31))

        registration_date = (
            event["event_date"]
            - pd.Timedelta(days=days_before)
        )

        # Simulate attendance
        attended = rng.random() < 0.75

        attendance_status = (
            "Attended" if attended else "Absent"
        )

        # Satisfaction only recorded for attendees
        satisfaction = (
            int(rng.integers(1, 6)) if attended else np.nan
        )

        registration_records.append({
            "student_id": student_id,
            "event_id": event["event_id"],
            "registration_date": registration_date,
            "attendance_status": attendance_status,
            "satisfaction_score": satisfaction,
            "registration_channel": rng.choice([
                "Website", "Social Media", "Referral", "University"
            ])
        })

registrations = pd.DataFrame(registration_records)

registrations.insert(
    0,
    "registration_id",
    range(1, len(registrations) + 1)
)
registrations["satisfaction_score"] = (
    registrations["satisfaction_score"].astype("Int64")
)
# ----------------------------------
# 4. EXPORT DATASETS
# ----------------------------------

students.to_csv(
    RAW_DIR / "students.csv", index=False
)

events.to_csv(
    RAW_DIR / "events.csv", index=False
)

registrations.to_csv(
    RAW_DIR / "registrations.csv", index=False
)

print("StudentPulse datasets generated successfully!")

print("\nDataset dimensions:")
print("Students:", students.shape)
print("Events:", events.shape)
print("Registrations:", registrations.shape)

print("\nRegistration preview:")
print(registrations.head())

print("\nFiles saved in:", RAW_DIR)
