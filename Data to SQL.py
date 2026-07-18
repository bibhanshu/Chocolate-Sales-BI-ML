import pandas as pd
from sqlalchemy import create_engine
import urllib

# ── CONFIG ─────────────────────────────────────────────────
SERVER   =  r"Bibhanshu\SQLEXPRESS01"
DATABASE = "ChocolateDB"
PATH     = r"C:\Users\ACER\Desktop\Project BI"
# ───────────────────────────────────────────────────────────

params = urllib.parse.quote_plus(
    r"DRIVER={ODBC Driver 17 for SQL Server};"
    r"SERVER=Bibhanshu\SQLEXPRESS01;"
    r"DATABASE=ChocolateDB;"
    r"Trusted_Connection=yes;"
)

engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

# ── LOAD ALL 5 FILES ───────────────────────────────────────
files = {
    'sales_fact':       f'{PATH}\\sales_fact.xlsx',
    'dim_salesperson':  f'{PATH}\\dim_salesperson.xlsx',
    'dim_product':      f'{PATH}\\dim_product.xlsx',
    'dim_country':      f'{PATH}\\dim_country.xlsx',
    'monthly_targets':  f'{PATH}\\monthly_targets.xlsx',
}

print("Loading files into ChocolateDB...")
print("─" * 40)

for table, filepath in files.items():
    df = pd.read_excel(filepath)
    df.to_sql(table, engine, if_exists='replace', index=False)
    print(f"✅ {table:20s} → {len(df)} rows loaded")

print("─" * 40)
print("🎉 All tables loaded! Open SSMS and verify.")