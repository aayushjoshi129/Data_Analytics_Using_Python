CREATE DATABASE DATA_ANALYSIS_USING_PYTHON;

USE DATA_ANALYSIS_USING_PYTHON;

-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name NVARCHAR(50),
    customer_contact NVARCHAR(15),
    customer_city NVARCHAR(50)
);

-- Orders Table
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    dish_name NVARCHAR(50),
    customer_id INT,
    order_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Dish Table
CREATE TABLE Dish (
    name NVARCHAR(50) PRIMARY KEY,
    price DECIMAL(10, 2)
);

-- Area Table
CREATE TABLE Area (
    city NVARCHAR(50),
    pincode NVARCHAR(6),
    PRIMARY KEY (city, pincode)
);


-- Insert into Customers
INSERT INTO Customers (customer_id, customer_name, customer_contact, customer_city)
VALUES 
(1, 'John Doe', '1234567890', 'New York'),
(2, 'Jane Smith', '9876543210', 'Los Angeles'),
(3, 'Alice Brown', '5678901234', 'Chicago'),
(4, 'Michael Johnson', '1122334455', 'San Francisco');

-- Insert into Orders
INSERT INTO Orders (order_id, dish_name, customer_id, order_date)
VALUES
(101, 'Pizza', 1, '2021-05-15'),
(102, 'Burger', 2, '2021-11-20'),
(103, 'Pasta', 3, '2022-03-10'),
(104, 'Salad', 1, '2022-07-25'),
(105, 'Pizza', 2, '2023-01-12'),
(106, 'Burger', 4, '2023-06-18'),
(107, 'Pasta', 3, '2023-09-08'),
(108, 'Pizza', 1, '2024-02-14'),
(109, 'Salad', 4, '2024-05-20');


-- Insert into Dish
INSERT INTO Dish (name, price)
VALUES
('Pizza', 8.99),
('Burger', 5.49),
('Pasta', 7.99),
('Salad', 4.99);

-- Insert into Area
INSERT INTO Area (city, pincode)
VALUES
('New York', '10001'),
('Los Angeles', '90001'),
('Chicago', '60601'),
('San Francisco', '94101'),
('Miami', '33101');

SELECT * FROM CUSTOMERS;

SELECT * FROM ORDERS;

SELECT * FROM AREA;

SELECT * FROM DISH;

-- Q1) FIND CUSTOMERS WHO ORDERED MORE THAN 1 DISHES EVER

-- FINAL SOLUTION QUERY

SELECT CUSTOMER_ID, CUSTOMER_NAME FROM CUSTOMERS WHERE CUSTOMER_ID IN (
SELECT DISTINCT O1.CUSTOMER_ID FROM ORDERS O1 JOIN ORDERS O2 ON O1.CUSTOMER_ID = O2.CUSTOMER_ID 
AND O1.DISH_NAME <> O2.DISH_NAME
)

-- WAY 2
SELECT 
    c.customer_id, 
    c.customer_name, 
    COUNT(DISTINCT o.dish_name) AS unique_dishes
FROM 
    Customers c
INNER JOIN 
    Orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.customer_name
HAVING 
    COUNT(DISTINCT o.dish_name) > 1;



-- Q2) FIND THE yearly order trends and total revenue

-- FINAL SOLUTION QUERY

SELECT YEAR(ORDER_DATE) AS ORDER_YEAR, SUM(PRICE) AS REVENUE, COUNT(*) AS ORDER_COUNT 
FROM ORDERS O INNER JOIN DISH D ON 
O.DISH_NAME = D.NAME GROUP BY YEAR(ORDER_DATE) ORDER BY REVENUE DESC;

-- Q3) FIND THE AREA WISE order trends and total revenue

-- FINAL SOLUTION QUERY

SELECT CITY, ISNULL(SUM(PRICE),0) AS REVENUE, COUNT(O.ORDER_ID) AS ORDER_COUNT FROM 
AREA A LEFT JOIN CUSTOMERS C ON UPPER(A.CITY) = UPPER(C.CUSTOMER_CITY)
LEFT JOIN ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID 
LEFT JOIN DISH D ON UPPER(D.NAME) = UPPER(O.DISH_NAME)
GROUP BY CITY ORDER BY REVENUE DESC;


-- WAY 2 
SELECT 
    A.CITY AS Area,
    COUNT(O.ORDER_ID) AS Order_Count,
    SUM(D.PRICE) AS Total_Revenue
FROM 
    AREA A
LEFT JOIN 
    CUSTOMERS C ON UPPER(A.CITY) = UPPER(C.CUSTOMER_CITY)
LEFT JOIN 
    ORDERS O ON C.CUSTOMER_ID = O.CUSTOMER_ID
LEFT JOIN 
    DISH D ON UPPER(O.DISH_NAME) = UPPER(D.NAME)
GROUP BY 
    A.CITY
ORDER BY 
    Total_Revenue DESC;
