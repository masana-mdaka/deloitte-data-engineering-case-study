import pandas as pd
from sqlalchemy import create_engine
from urllib.parse import quote

# Define database credentials
username = 'root'
password = 'Lonene28@@@@@'
encoded_password = quote(password)
host = '127.0.0.1'
database = 'db'

# Create a database connection string
connection_string = f'mysql+pymysql://{username}:{encoded_password}@{host}/{database}'

# Create a SQLAlchemy engine
engine = create_engine(connection_string)

# Read the CSV files
weather_df = pd.read_csv('Weather.csv') # Read Weather data saved from weather_data_collection.ipynb script
listings_df = pd.read_csv('Listings.csv') # Read Weather data saved from listing_data_cleaning.ipynb script
reviews_df = pd.read_csv('Reviews.csv') # Read Weather data saved from review_sentiments.ipynb script

# Re-order columns to database table column order
weather_df = weather_df[['listing_id','reviewer_id','precipitation','temperature_max','temperature_min']] 
listings_df = listings_df[['listing_id','name','neighbourhood','latitude','longitude','room_type','price']]
reviews_df = reviews_df[['listing_id','reviewer_id','precipitation','temperature_max','temperature_min']]

# Insert data into the table
weather_df.to_sql(name='Weather', con=engine, if_exists='append', index=False)
listings_df.to_sql(name='Listings', con=engine, if_exists='append', index=False)
reviews_df.to_sql(name='Reviews', con=engine, if_exists='append', index=False)

