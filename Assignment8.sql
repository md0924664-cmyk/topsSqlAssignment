-- 1. Create two tables in your SQL database: Users (user_id, username, city) and Orders (order_id, user_id, product, amount). Insert at least 
--    3 users and 5 orders, making sure some users have no orders.

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    city VARCHAR(50)
);

-- for table creation :
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- for data insert in users  :

INSERT INTO Users (user_id, username, city)
VALUES
(1, 'Mihir', 'Ahmedabad'),
(2, 'Rahul', 'Surat'),
(3, 'Priya', 'Vadodara');

-- for data insert in orders  :

INSERT INTO Orders (order_id, user_id, product, amount)
VALUES
(101, 1, 'Pizza', 350),
(102, 1, 'Burger', 250),
(103, 2, 'Biryani', 300),
(104, 2, 'Sandwich', 180),
(105, 1, 'Pasta', 280);


----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Write an SQL query using INNER JOIN to list all usernames and their ordered products, showing only users who have placed at least one order.

SELECT Users.username, Orders.product
FROM Users
INNER JOIN Orders
ON Users.user_id = Orders.user_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Write an SQL query using LEFT JOIN to display all usernames along with their ordered products. For users who haven't placed any orders, show NULL for the product.

SELECT Users.username, Orders.product
FROM Users
LEFT JOIN Orders
ON Users.user_id = Orders.user_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Write an SQL query using RIGHT JOIN to show all orders and the corresponding username for each order. If an order has a user_id that doesn't exist in the Users table, 
--    display NULL for the username.<br><br><em><strong>Hint:</strong> Try deleting one user and keeping their order to test this case.</em>

SELECT Orders.order_id, 
       Orders.product, 
       Orders.user_id,
       Users.username
FROM Users
RIGHT JOIN Orders
ON Users.user_id = Orders.user_id;

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Suppose you want to analyze food delivery data like Zomato. Create a CustomerSegments table (segment_id, segment_name), and link it to Users with a foreign key. 
--    Write an SQL query to show each username, their segment name, and total order amount (use JOINs as needed).

CREATE TABLE CustomerSegments (
    segment_id INT PRIMARY KEY,
    segment_name VARCHAR(50)
);

--add segment_id to Users table :
ALTER TABLE Users
ADD segment_id INT;

-- Add foregin key :
ALTER TABLE Users
ADD CONSTRAINT fk_user_segment
FOREIGN KEY (segment_id) REFERENCES CustomerSegments(segment_id);

--Insert data in CustomerSegments table :
INSERT INTO CustomerSegments (segment_id, segment_name)
VALUES
(1, 'Premium'),
(2, 'Regular'),
(3, 'Occasional');

-- Update Users table to assign segments :
UPDATE Users
SET segment_id = 1
WHERE user_id = 1;

UPDATE Users
SET segment_id = 2
WHERE user_id = 2;

UPDATE Users
SET segment_id = 3
WHERE user_id = 3;


SELECT Users.username,
    CustomerSegments.segment_name,
    COALESCE(SUM(Orders.amount), 0) AS total_order_amount
FROM Users
INNER JOIN CustomerSegments
    ON Users.segment_id = CustomerSegments.segment_id
LEFT JOIN Orders
    ON Users.user_id = Orders.user_id
GROUP BY Users.user_id, Users.username, CustomerSegments.segment_name;