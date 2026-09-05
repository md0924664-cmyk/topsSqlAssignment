-- 1. Download a sample IPL match data CSV file and load it into a new SQL table called ipl_matches using your preferred SQL tool (MySQL Workbench, DBeaver, 
--    or Azure Data Studio).

CREATE TABLE ipl_matches (
    id INT PRIMARY KEY,
    season YEAR,
    city VARCHAR(50),
    date DATE,
    team1 VARCHAR(50),
    team2 VARCHAR(50),
    winner VARCHAR(50),
    win_by_runs INT,
    win_by_wickets INT,
    player_of_match VARCHAR(100),
    venue VARCHAR(100)
);
-- load csv data
LOAD DATA LOCAL INFILE '/path/to/matches.csv'
INTO TABLE ipl_matches
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- varify data
SELECT *
FROM ipl_matches;
SELECT COUNT(*) AS total_matches
FROM ipl_matches;

---------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Write a SQL query to select all matches where the team 'Mumbai Indians' played, then export the query results as a CSV file named mi_matches.csv.

SELECT *
FROM ipl_matches
WHERE team1 = 'Mumbai Indians'
   OR team2 = 'Mumbai Indians';

-- This query returns all matches in which Mumbai Indians participated.

---------------------------------------------------------------------------------------------------------------------------------------------
-- 3. Connect Microsoft Excel to your SQL database and import the ipl_matches table. Create a simple table in Excel that shows the total matches played by each team.

-- A simple SQL approach is:
SELECT team, COUNT(*) AS total_matches 
    FROM ( 
        SELECT team1 AS team FROM ipl_matches 
        UNION ALL
        SELECT team2 AS team FROM ipl_matches
         ) AS teams 
         GROUP BY team;

---------------------------------------------------------------------------------------------------------------------------------------------
-- 4. Connect Power BI Desktop to your SQL database, import the ipl_matches table, and create a pivot chart showing the number of wins for each team.



---------------------------------------------------------------------------------------------------------------------------------------------
-- 5. Use Python (with pandas and sqlalchemy) to read the mi_matches.csv file, filter matches where 'Mumbai Indians' won, and insert those rows into a new SQL
--    table called mi_wins.<br><br><em><strong>Hint:</strong> Use pandas.read_csv(), DataFrame filtering, and to_sql() for this task.</em>

import pandas as pd from sqlalchemy 
import create_engine

-- 1. Read CSV file 
df = pd.read_csv("mi_matches.csv")

-- 2. Filter matches where Mumbai Indians won 
mi_wins = df[df["winner"] == "Mumbai Indians"] 

-- 3. Create SQLAlchemy connection 
engine = create_engine( 
    "mysql+pymysql://root:password@localhost/ipl_db" ) 

-- 4. Insert filtered data into SQL table
 mi_wins.to_sql( 
        "mi_wins", 
         con=engine, 
         if_exists="replace",
          index=False 
          ) 
          print("Mumbai Indians winning matches inserted successfully.") 
          
-- 5. Display the data 
print(mi_wins)