# These generate unique avatars based on initials — always free!
# Format: https://ui-avatars.com/api/?name=John+Doe&background=random

import pandas as pd

PATH = r"C:\Users\ACER\Desktop\Project BI"
df = pd.read_excel(f"{PATH}\\dim_salesperson.xlsx")

# Generate avatar URL based on name
df['profile_image'] = df['salesperson_name'].apply(
    lambda name: f"https://ui-avatars.com/api/?name={name.replace(' ', '+')}&size=200&background=random&color=fff&bold=true&rounded=true"
)

df.to_excel(f"{PATH}\\dim_salesperson.xlsx", index=False)
print("✅ Profile images added!")
print(df[['salesperson_name', 'profile_image']].to_string())