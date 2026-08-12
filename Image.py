import pandas as pd

# Chocolate product image URLs from Unsplash (free)
image_urls = {
    'Mint Chip Choco': 'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=400',
    '85% Dark Bars': 'https://images.unsplash.com/photo-1548907040-4baa42d10919?w=400',
    'Peanut Butter Cubes': 'https://images.unsplash.com/photo-1610450949065-1f2841536c88?w=400',
    'Smooth Sliky Salty': 'https://images.unsplash.com/photo-1599599810769-bcde5a160d32?w=400',
    '99% Dark & Pure': 'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400',
    'After Nines': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
    '50% Dark Bites': 'https://images.unsplash.com/photo-1511381939415-e44015466834?w=400',
    'Orange Choco': 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=400',
    'Eclairs': 'https://images.unsplash.com/photo-1549590143-d5855148a9d5?w=400',
    'Drinking Coco': 'https://images.unsplash.com/photo-1517578239113-b03992dcdd25?w=400',
    'Organic Choco Syrup': 'https://images.unsplash.com/photo-1481391243133-f96216dcb5d2?w=400',
    'Milk Bars': 'https://images.unsplash.com/photo-1574570068036-de13f4ab3d4a?w=400',
    'Fruit & Nut Bars': 'https://images.unsplash.com/photo-1606313564200-e75d5e30476c?w=400',
    'Manuka Honey Choco': 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=400',
    'White Choc': 'https://images.unsplash.com/photo-1481391243133-f96216dcb5d2?w=400',
    'Almond Choco': 'https://images.unsplash.com/photo-1610450949065-1f2841536c88?w=400',
    'Raspberry Choco': 'https://images.unsplash.com/photo-1621939514649-280e2ee25f60?w=400',
    'Choco Coated Almonds': 'https://images.unsplash.com/photo-1599599810769-bcde5a160d32?w=400',
    'Spicy Special Slims': 'https://images.unsplash.com/photo-1542990253-0d0f5be5f0ed?w=400',
    "Baker's Choco Chips": 'https://images.unsplash.com/photo-1606312619070-d48b4c652a52?w=400',
    'Caramel Stuffed Bars': 'https://images.unsplash.com/photo-1578985545062-69928b1d9587?w=400',
    '70% Dark Bites': 'https://images.unsplash.com/photo-1548907040-4baa42d10919?w=400',
}

# Load existing dim_product
PATH = r"C:\Users\ACER\Desktop\Project BI"
df = pd.read_excel(f"{PATH}\\dim_product.xlsx")

# Add image URL column
df['image_url'] = df['product_name'].map(image_urls)

# Save back
df.to_excel(f"{PATH}\\dim_product.xlsx", index=False)
print("✅ Image URLs added to dim_product.xlsx!")
print(df[['product_name', 'image_url']].to_string())