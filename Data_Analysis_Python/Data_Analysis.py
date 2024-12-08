import pandas as pd

orders_df = pd.read_csv('Orders.csv')
customers_df = pd.read_csv('Customers.csv')
area_df = pd.read_csv('Area.csv')
dish_df = pd.read_csv('Dish.csv')

print('CUSTOMERS', customers_df,'\n');
print('ORDERS', orders_df,'\n');
print('DISH', dish_df,'\n');
print('AREA', area_df,'\n');

# Q1) FIND CUSTOMERS WHO ORDERED MORE THAN 1 DISHES EVER

# # joining orders and customers table
# merged_df = pd.merge(customers_df, orders_df, on="customer_id")
# print(merged_df)
#
# # Group by customer_id and customer_name, and count unique dishes
# result_df = (
#     merged_df.groupby(["customer_id", "customer_name"])["dish_name"]
#     .nunique()
#     .reset_index(name="unique_dishes")
#     .query("unique_dishes > 1")
# )
#
# print(result_df)

# # WAY 2
#
# # Self-join logic in Pandas
# merged_orders = orders_df.merge(
#     orders_df,
#     on="customer_id",
#     suffixes=("_1", "_2")
# )
#
# # Filter where the dishes are different (O1.dish_name <> O2.dish_name)
# filtered_orders = merged_orders[merged_orders["dish_name_1"] != merged_orders["dish_name_2"]]
#
# # Get distinct customer_ids from filtered_orders
# distinct_customers = filtered_orders["customer_id"].drop_duplicates()
#
# # Filter customers who meet the condition
# result_df = customers_df[customers_df["customer_id"].isin(distinct_customers)]
#
# # Display the result
# print(result_df)

# Q2) FIND THE yearly order trends and total revenue

# # Convert order_date to datetime format
# orders_df['order_date'] = pd.to_datetime(orders_df['order_date'])
#
# # Merge the orders and dish dataframes on 'dish_name' and 'name'
# merged_df = pd.merge(orders_df, dish_df, how="inner", left_on="dish_name", right_on="name")
#
# # Extract the year from the order_date column
# merged_df['order_year'] = merged_df['order_date'].dt.year
#
# # Group by order_year and aggregate the data
# result_df = merged_df.groupby('order_year').agg(
#     revenue=('price', 'sum'),
#     order_count=('order_id', 'count')
# ).reset_index()
#
# # Sort by revenue in descending order
# result_df = result_df.sort_values(by='revenue', ascending=False)
#
# # Display the result
# print(result_df)

# Q3) FIND THE Area wise order trends and total revenue

# # Merge DataFrames with LEFT JOIN equivalent in Pandas
# merged_df = pd.merge(area_df, customers_df, how="left", left_on="city", right_on="customer_city")
# merged_df = pd.merge(merged_df, orders_df, how="left", on='customer_id')
# merged_df = pd.merge(merged_df, dish_df, how="left", left_on="dish_name", right_on="name")
#
# # Group by area (customer_city or city) and calculate order trends and total revenue
# area_trends_df = merged_df.groupby('city').agg(
#     order_count=('order_id', 'count'),
#     total_revenue=('price', 'sum')
# ).reset_index()
#
# # Handle the case where there are no orders (e.g., Miami), ensuring total revenue is 0.00
# area_trends_df['total_revenue'] = area_trends_df['total_revenue'].fillna(0.00)
#
# # Sort by total revenue in descending order
# area_trends_df = area_trends_df.sort_values(by='total_revenue', ascending=False)
#
# # Display the result
# print(area_trends_df)

# Merge DataFrames with LEFT JOIN equivalent in Pandas
merged_df = pd.merge(area_df, customers_df, how="left", left_on="city", right_on="customer_city")
merged_df = pd.merge(merged_df, orders_df, how="left", on='customer_id')
merged_df = pd.merge(merged_df, dish_df, how="left", left_on="dish_name", right_on="name")
# print(merged_df)

# Order Volume and Frequency Analysis
order_frequency_df = merged_df.groupby('customer_id')['order_id'].nunique().reset_index()
# print(order_frequency_df)

# Dish Popularity and Revenue Contribution:
dish_popularity_df = merged_df.groupby('dish_name').agg(
    order_count=('order_id', 'count'),
    total_revenue=('price', 'sum')
).reset_index()
# print(dish_popularity_df)

# Seasonality and Trend Analysis
merged_df['order_year'] = pd.to_datetime(merged_df['order_date']).dt.year
merged_df['order_month'] = pd.to_datetime(merged_df['order_date']).dt.month
seasonality_df = merged_df.groupby(['order_year', 'order_month']).agg(
    order_count=('order_id', 'count'),
    total_revenue=('price', 'sum')
).reset_index()
# print(seasonality_df)

