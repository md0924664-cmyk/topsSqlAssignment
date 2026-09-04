-- Database Creation 
--2.Open MySQL Workbench or DB Browser, connect to your local MySQL server, and create a new database called music_streaming_db.

CREATE DATABASE music_streaming_db;

SHOW DATABASES;

USE music_streaming_db;

----------------------------------------------------------------------------------------------------------------------------------
--3.write the SQL command to create a new database named food_delivery_db and execute it in your SQL Workbench or DB Browser.
--  <br><br><em><strong>Hint:</strong> Use the CREATE DATABASE statement.</em>

CREATE DATABASE food_delivery_db;

SHOW DATABASES;

----------------------------------------------------------------------------------------------------------------------------------
--4.List 3 differences between MySQL and PostgreSQL in terms of features or use cases, and give one example of a popular app 
--  or company that uses each.

-- | Feature                          | MySQL                                                                           | PostgreSQL                                                                                       |
-- | -------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
-- |   1. Main Use                    | Commonly used for web applications and read-heavy applications.                 | Commonly used for complex and data-intensive applications.                                       |
-- |   2. Advanced Features           | Simple and easy to use, with strong support for common SQL operations.          | Provides advanced features such as powerful indexing, complex queries, and extensibility.        |
-- |   3. Performance & Scalability   | Often preferred for applications where fast reads and simplicity are important. | Often preferred when complex transactions, analytics, and advanced data operations are required. |
-- |  Example                       | **Facebook** uses MySQL extensively.                                            | **Instagram** uses PostgreSQL.                                                                   |--
