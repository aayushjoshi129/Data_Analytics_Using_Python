CREATE DATABASE MONTHLY_TRANSACTIONS;

USE MONTHLY_TRANSACTIONS;

CREATE TABLE TRANSACTIONS (
ID INT PRIMARY KEY,
COUNTRY VARCHAR (5),
STATE VARCHAR (20) CHECK (STATE IN ('approved', 'declined')),
AMOUNT DECIMAL (10,2),
TRANS_DATE DATE
)

-- Insert data into the Transactions table
INSERT INTO Transactions (id, country, state, amount, trans_date)
VALUES
(121, 'US', 'approved', 1000.00, '2018-12-18'),
(122, 'US', 'declined', 2000.00, '2018-12-19'),
(123, 'US', 'approved', 2000.00, '2019-01-01'),
(124, 'DE', 'approved', 2000.00, '2019-01-07');

SELECT * FROM TRANSACTIONS;

SELECT FORMAT(trans_date, 'yyyy-MM') AS MON, 
COUNTRY, 
COUNT(FORMAT(trans_date, 'yyyy-MM')) AS TRANS_COUNT, 
SUM(CASE WHEN STATE='approved' THEN 1 ELSE 0 END) AS APPROVED_COUNT,
SUM(AMOUNT) AS TRANS_TOTAL_AMOUNT, 
SUM(CASE WHEN STATE='approved' THEN AMOUNT ELSE 0 END) AS APPROVED_TOTAL_AMOUNT
FROM TRANSACTIONS 
GROUP BY FORMAT(trans_date, 'yyyy-MM'), COUNTRY
ORDER BY MON ASC, COUNTRY DESC;