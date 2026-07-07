import snowflake.connector
import pandas as pd
from snowflake.connector.pandas_tools import write_pandas

# Connect to Snowflake
conn = snowflake.connector.connect(
    account='reebjiy-sy33573',
    user='GJIXIE31',
    password='GJixie@16121993',
    role='ACCOUNTADMIN',
    warehouse='COMPUTE_WH',
    database='MEDICARE_DB',
    schema='DBT_LEARNING'
)

cursor = conn.cursor()

# Create schema if not exists
cursor.execute("CREATE SCHEMA IF NOT EXISTS DBT_LEARNING")
cursor.execute("USE SCHEMA DBT_LEARNING")

# Read first 100k rows of CSV
print("Reading CSV...")
df = pd.read_csv(
    r'C:\Users\jixie.george\my_first_project\data\Medicare_Physician_Other_Practitioners_by_Provider_and_Service_2024.csv',
    nrows=100000,
    low_memory=False
)

# Clean column names
df.columns = [col.replace(' ', '_').replace('/', '_').replace('-', '_') for col in df.columns]

print(f"Loaded {len(df)} rows, {len(df.columns)} columns")

# Convert all columns to string to avoid type conflicts
df = df.astype(str)

# Write to Snowflake
print("Uploading to Snowflake...")
success, nchunks, nrows, _ = write_pandas(conn, df, 'MEDICARE_RAW', auto_create_table=True)

print(f"Done! Uploaded {nrows} rows successfully")

cursor.close()
conn.close()
