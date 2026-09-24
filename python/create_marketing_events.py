import pandas as pd
import numpy as np
from pathlib import Path

np.random.seed(42)

# Number of records
n = 100000

# Data options
channels = [
    "Google Ads",
    "Social Media",
    "Email",
    "YouTube",
    "LinkedIn"
]

campaigns = [f"CMP{i:03d}" for i in range(1, 21)]

event_types = [
    "Impression",
    "Click",
    "Lead",
    "Qualified Lead",
    "Customer"
]

devices = [
    "Mobile",
    "Desktop",
    "Tablet"
]

# Create dataset
events = pd.DataFrame({

    "Event_ID": [
        f"EVT{i:06d}"
        for i in range(1, n + 1)
    ],

    "Lead_ID": [
        f"LEAD{np.random.randint(1, 50001):05d}"
        for _ in range(n)
    ],

    "Campaign_ID": np.random.choice(
        campaigns,
        n
    ),

    "Channel": np.random.choice(
        channels,
        n,
        p=[0.28, 0.30, 0.18, 0.14, 0.10]
    ),

    "Event_Type": np.random.choice(
        event_types,
        n,
        p=[0.58, 0.20, 0.12, 0.06, 0.04]
    ),

    "Event_Date": np.random.choice(
        pd.date_range(
            "2025-01-01",
            "2025-12-31"
        ),
        n
    ),

    "Device": np.random.choice(
        devices,
        n,
        p=[0.62, 0.30, 0.08]
    )
})

# Convert date format
events["Event_Date"] = pd.to_datetime(
    events["Event_Date"]
).dt.strftime("%Y-%m-%d")

# Create folder
folder = Path("data/raw")
folder.mkdir(
    parents=True,
    exist_ok=True
)

# Save CSV
file_path = folder / "marketing_events.csv"

events.to_csv(
    file_path,
    index=False
)

print("Marketing Events dataset created successfully!")
print("File:", file_path)
print("Rows:", len(events))
print("Columns:", len(events.columns))

print("\nEvent Type Summary:")
print(events["Event_Type"].value_counts())