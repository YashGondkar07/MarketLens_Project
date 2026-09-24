import pandas as pd
import numpy as np
from pathlib import Path

np.random.seed(42)

n = 20000

channels = [
    "Google Ads",
    "Social Media",
    "Email",
    "YouTube",
    "LinkedIn"
]

# Generate customer journeys
journeys = pd.DataFrame({

    "Customer_ID": [
        f"CUST{i:06d}"
        for i in range(1, n + 1)
    ],

    "First_Touch": np.random.choice(
        channels, n
    ),

    "Second_Touch": np.random.choice(
        channels, n
    ),

    "Third_Touch": np.random.choice(
        channels, n
    ),

    "Last_Touch": np.random.choice(
        channels, n
    ),

    "Converted": np.random.choice(
        [0, 1],
        n,
        p=[0.65, 0.35]
    )
})

# Generate revenue only for converted customers
journeys["Revenue"] = np.where(
    journeys["Converted"] == 1,
    np.random.randint(500, 10000, n),
    0
)

# Create data/raw folder
folder = Path("data/raw")
folder.mkdir(
    parents=True,
    exist_ok=True
)

# Save CSV
file_path = folder / "customer_journeys.csv"

journeys.to_csv(
    file_path,
    index=False
)

print("Customer Journeys dataset created successfully!")
print("File:", file_path)
print("Rows:", len(journeys))
print("Columns:", len(journeys.columns))

print("\nConversion Summary:")
print(journeys["Converted"].value_counts())