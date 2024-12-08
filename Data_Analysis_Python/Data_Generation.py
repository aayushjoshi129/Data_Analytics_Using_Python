import pandas as pd

# Data for each table
customers_data = {
    "customer_id": [1, 2, 3, 4],
    "customer_name": ["John Doe", "Jane Smith", "Alice Brown", "Michael Johnson"],
    "customer_contact": ["1234567890", "9876543210", "5678901234", "1122334455"],
    "customer_city": ["New York", "Los Angeles", "Chicago", "San Francisco"],
}

orders_data = {
    "order_id": [101, 102, 103, 104, 105, 106, 107, 108, 109],
    "dish_name": ["Pizza", "Burger", "Pasta", "Salad", "Pizza", "Burger", "Pasta", "Pizza", "Salad"],
    "customer_id": [1, 2, 3, 1, 2, 4, 3, 1, 4],
    "order_date": [
        "2021-05-15", "2021-11-20", "2022-03-10", "2022-07-25",
        "2023-01-12", "2023-06-18", "2023-09-08", "2024-02-14",
        "2024-05-20",
    ],
}

dish_data = {
    "name": ["Pizza", "Burger", "Pasta", "Salad"],
    "price": [8.99, 5.49, 7.99, 4.99],
}

area_data = {
    "city": ["New York", "Los Angeles", "Chicago", "San Francisco", "Miami"],
    "pincode": ["10001", "90001", "60601", "94101", "33101"],
}

# Creating DataFrames
customers_df = pd.DataFrame(customers_data)
orders_df = pd.DataFrame(orders_data)
dish_df = pd.DataFrame(dish_data)
area_df = pd.DataFrame(area_data)

print('CUSTOMERS', customers_df,'\n');
print('ORDERS', orders_df,'\n');
print('DISH', dish_df,'\n');
print('AREA', area_df,'\n');

csv_file_paths = {
    "customers": "D:\Learning_Projects\Data_Analysis_Python/Customers.csv",
    "orders": "D:\Learning_Projects\Data_Analysis_Python/Orders.csv",
    "dish": "D:\Learning_Projects\Data_Analysis_Python/Dish.csv",
    "area": "D:\Learning_Projects\Data_Analysis_Python/Area.csv",
}

customers_df.to_csv(csv_file_paths["customers"], index=False)
orders_df.to_csv(csv_file_paths["orders"], index=False)
dish_df.to_csv(csv_file_paths["dish"], index=False)
area_df.to_csv(csv_file_paths["area"], index=False)

csv_file_paths