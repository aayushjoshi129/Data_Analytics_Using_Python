CREATE DATABASE USER_REGISTER;

USE USER_REGISTER;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(50)
);

INSERT INTO Users (user_id, user_name)
VALUES
(6, 'Alice'),
(2, 'Bob'),
(7, 'Alex');

CREATE TABLE Register (
    contest_id INT,
    user_id INT,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Register (contest_id, user_id)
VALUES
(215, 6),
(209, 2),
(208, 2),
(210, 6),
(208, 6),
(209, 7),
(209, 6),
(215, 7),
(208, 7),
(210, 2),
(207, 2),
(210, 7);


SELECT * FROM USERS;

SELECT * FROM REGISTER;


SELECT ROUND(2.339,2);



SELECT R.CONTEST_ID, ROUND(CAST(COUNT(R.CONTEST_ID) AS FLOAT)/(SELECT COUNT(*) FROM USERS)*100,2) AS PERCENTAGE FROM REGISTER R LEFT JOIN USERS U 
ON R.USER_ID = U.USER_ID GROUP BY R.CONTEST_ID ORDER BY PERCENTAGE DESC, CONTEST_ID ASC;