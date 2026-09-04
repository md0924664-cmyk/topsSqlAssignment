-- 1.Create a table called Orders with columns: order_id, user_id, order_amount, and app_name (e.g., 'Zomato', 'Swiggy', 'Flipkart'). 
--   Insert at least 10 sample records with different users and apps. Write an SQL query using the OVER() function to display each order's 
--   amount along with the total order amount for all orders.

--Create the Orders table :
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    user_id INT,
    order_amount DECIMAL(10,2),
    app_name VARCHAR(50)
);

--inser data into the Orders table :
INSERT INTO Orders (order_id, user_id, order_amount, app_name)
VALUES
(1, 101, 500, 'Zomato'),
(2, 102, 750, 'Swiggy'),
(3, 101, 300, 'Flipkart'),
(4, 103, 1200, 'Zomato'),
(5, 102, 450, 'Swiggy'),
(6, 104, 900, 'Flipkart'),
(7, 103, 650, 'Zomato'),
(8, 101, 800, 'Swiggy'),
(9, 104, 400, 'Flipkart'),
(10, 105, 1000, 'Zomato');

SELECT 
    order_id,
    user_id,
    order_amount,
    app_name,
    SUM(order_amount) OVER() AS total_order_amount
FROM Orders;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 2.Using the Orders table, write an SQL query to show each user's order_id, order_amount, and the average order_amount for that user using 
--   the OVER(PARTITION BY user_id) clause.<br><br><em><strong>Hint:</strong> Use AVG(order_amount) OVER(PARTITION BY user_id) to get the per-user average.</em>



SELECT 
    user_id,
    order_id,
    order_amount,
    AVG(order_amount) OVER(PARTITION BY user_id) AS user_average
FROM Orders;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 3.Suppose you have a table called Playlist with columns: song_id, user_id, and duration_sec. Write an SQL query to display each song's duration,
--   and the total duration of songs added by each user using SUM(duration_sec) OVER(PARTITION BY user_id).

--create the Playlist table:
CREATE TABLE Playlist (
    song_id INT,
    user_id INT,
    duration_sec INT
);
-- Insert data into the Playlist table:
INSERT INTO Playlist (song_id, user_id, duration_sec)
VALUES
(101, 1, 240),
(102, 1, 300),
(103, 1, 210),
(104, 2, 250),
(105, 2, 320),
(106, 3, 200),
(107, 3, 280),
(108, 3, 350);

SELECT 
    song_id,
    user_id,
    duration_sec,
    SUM(duration_sec) OVER(PARTITION BY user_id) AS total_duration
FROM Playlist;

----------------------------------------------------------------------------------------------------------------------------------------------------
-- 4.Given a table named MovieRatings with columns: rating_id, user_id, movie_name, and rating (1-5), write an SQL query to show each rating, 
--   the average rating per movie, and the difference between the user's rating and the movie's average rating using window functions.
--   <br><br><em><strong>Hint:</strong> Use AVG(rating) OVER(PARTITION BY movie_name) and subtract it from the user's rating.</em>

--create the MovieRatings table:
CREATE TABLE MovieRatings (
    rating_id INT PRIMARY KEY,
    user_id INT,
    movie_name VARCHAR(100),
    rating DECIMAL(2,1)
);

-- Insert data into the MovieRatings table:
INSERT INTO MovieRatings (rating_id, user_id, movie_name, rating)   
VALUES
(1, 101, 'Inception', 5),
(2, 102, 'Inception', 4),
(3, 103, 'Inception', 5),
(4, 104, 'The Matrix', 4),
(5, 105, 'The Matrix', 5),
(6, 101, 'The Matrix', 3),
(7, 102, 'Interstellar', 5),
(8, 103, 'Interstellar', 4),
(9, 104, 'Interstellar', 5),
(10, 105, 'Inception', 3);  


SELECT 
    user_id,
    movie_name,
    rating,
    AVG(rating) OVER(PARTITION BY movie_name) AS movie_average,
    rating - AVG(rating) OVER(PARTITION BY movie_name) AS rating_difference
FROM MovieRatings;