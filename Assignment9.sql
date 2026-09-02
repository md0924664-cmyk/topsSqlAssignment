
--1.Create two tables, influencers and brands, with at least 3 sample rows each. Use a FULL OUTER JOIN to list all influencers and brands,
--  showing influencer_name and brand_name, matching on city. If there is no match,display NULL for the missing side.
--  <br><br><em><strong>Hint:</strong> Use LEFT JOIN, RIGHT JOIN, and UNION if your SQL dialect does not support FULL OUTER JOIN directly.</em>


CREATE TABLE influencers (
    influencer_id INT PRIMARY KEY,
    influencer_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE brands (
    brand_id INT PRIMARY KEY,
    brand_name VARCHAR(100),
    city VARCHAR(50)
);


-- Insert sample influencers :
INSERT INTO influencers (influencer_id, influencer_name, city)
VALUES
(1, 'Sagar', 'Ahmedabad'),
(2, 'Rahul', 'Surat'),
(3, 'Priya', 'Vadodara');


-- Insert sample brands :
INSERT INTO brands (brand_id, brand_name, city)
VALUES
(101, 'Brand A', 'Ahmedabad'),
(102, 'Brand B', 'Surat'),
(103, 'Brand C', 'Rajkot');


-- MySQL does not directly support FULL OUTER JOIN.
-- Therefore, use LEFT JOIN + RIGHT JOIN with UNION.

SELECT i.influencer_name,
       b.brand_name
FROM influencers AS i
LEFT JOIN brands AS b
ON i.city = b.city

UNION

SELECT i.influencer_name,
       b.brand_name
FROM influencers AS i
RIGHT JOIN brands AS b
ON i.city = b.city;

-----------------------------------------------------------------------------------------------------------------------------------------------
--2. Given a table called playlists with columns (id, playlist_name, parent_playlist_id), write a SELF JOIN query to display each playlist alongside
--   its parent playlist's name, similar to how Spotify might nest playlists.


SELECT p.playlist_name AS playlist,
       parent.playlist_name AS parent_playlist
FROM playlists AS p
LEFT JOIN playlists AS parent
ON p.parent_playlist_id = parent.id;

-----------------------------------------------------------------------------------------------------------------------------------------------
--3.Create two tables: users and offers. Write a CROSS JOIN query to generate all possible combinations of usersand offers, displaying user_name and 
--  offer_title. Explain in a comment how this could be used for a Flipkart-style personalized offer campaign


CREATE TABLE users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100)
);

CREATE TABLE offers (
    offer_id INT PRIMARY KEY,
    offer_title VARCHAR(100)
);


INSERT INTO users (user_id, user_name)
VALUES
(1, 'Sagar'),
(2, 'Rahul'),
(3, 'Priya');


INSERT INTO offers (offer_id, offer_title)
VALUES
(101, '20% Off'),
(102, 'Free Delivery'),
(103, '₹100 Cashback');


SELECT u.user_name,
       o.offer_title
FROM users AS u
CROSS JOIN offers AS o;

-----------------------------------------------------------------------------------------------------------------------------------------------
--4. You have an employees table with columns (id, name, manager_id). Write a SELF JOIN to display each employee's name along with their manager's 
--   name. Then, modify your query to only show employees who do not have a manager (i.e., top-level managers).

SELECT e.name AS employee_name,
       m.name AS manager_name
FROM employees AS e
LEFT JOIN employees AS m
ON e.manager_id = m.id;


-- These are top-level managers.
SELECT e.name AS employee_name
FROM employees AS e
LEFT JOIN employees AS m
ON e.manager_id = m.id
WHERE e.manager_id IS NULL;

-----------------------------------------------------------------------------------------------------------------------------------------------
--5.Use ChatGPT or Copilot to help you write a SQL query that finds all pairs of users from a users table who live in the same city 
--  (excluding pairs where the user is compared with themselves). Paste the query and briefly describe how the AI helped you improve or debug it.

SELECT u1.user_name AS user_1,
       u2.user_name AS user_2,
       u1.city
FROM users AS u1
INNER JOIN users AS u2
ON u1.city = u2.city
AND u1.user_id < u2.user_id;


-- The condition u1.user_id < u2.user_id:
-- 1. Prevents a user from being matched with themselves.
-- 2. Prevents duplicate pairs such as A-B and B-A.