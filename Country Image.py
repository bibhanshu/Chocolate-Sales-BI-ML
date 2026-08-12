import pandas as pd

PATH = r"C:\Users\ACER\Desktop\Project BI"

# Flag image URLs from flagcdn.com — free, no copyright issues!
flag_urls = {
    'UK':          'https://flagcdn.com/w320/gb.png',
    'India':       'https://flagcdn.com/w320/in.png',
    'Australia':   'https://flagcdn.com/w320/au.png',
    'USA':         'https://flagcdn.com/w320/us.png',
    'Canada':      'https://flagcdn.com/w320/ca.png',
    'New Zealand': 'https://flagcdn.com/w320/nz.png',
}

df = pd.read_excel(f"{PATH}\\dim_country.xlsx")

df['flag_url'] = df['country_name'].map(flag_urls)

df.to_excel(f"{PATH}\\dim_country.xlsx", index=False)
print("✅ Flag URLs added to dim_country.xlsx!")
print(df[['country_name', 'flag_url']].to_string())