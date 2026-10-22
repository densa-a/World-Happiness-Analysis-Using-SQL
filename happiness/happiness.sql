CREATE DATABASE happiness_db;
USE happiness_db;
SELECT * FROM happiness_2016;
SELECT * FROM happiness_2017;
SELECT * FROM happiness_2018;
SELECT * FROM happiness_2019;
DESCRIBE happiness_2016;
DESCRIBE happiness_2017;
DESCRIBE happiness_2018;
DESCRIBE happiness_2019;

USE happiness_db;

CREATE TABLE happiness_all_years AS

SELECT
    2016 AS Year,
    Country,
    `Happiness Rank` AS Happiness_Rank,
    `Happiness Score` AS Happiness_Score,
    `Economy (GDP per Capita)` AS GDP_per_Capita,
    Family AS Social_Support,
    `Health (Life Expectancy)` AS Health,
    Freedom,
    Generosity
FROM happiness_2016

UNION ALL

SELECT
    2017 AS Year,
    Country,
    `Happiness.Rank` AS Happiness_Rank,
    `Happiness.Score` AS Happiness_Score,
    `Economy..GDP.per.Capita.` AS GDP_per_Capita,
    Family AS Social_Support,
    `Health..Life.Expectancy.` AS Health,
    Freedom,
    Generosity
FROM happiness_2017

UNION ALL

SELECT
    2018 AS Year,
    `Country or region` AS Country,
    `Overall rank` AS Happiness_Rank,
    Score AS Happiness_Score,
    `GDP per capita` AS GDP_per_Capita,
    `Social support` AS Social_Support,
    `Healthy life expectancy` AS Health,
    `Freedom to make life choices` AS Freedom,
    Generosity
FROM happiness_2018

UNION ALL

SELECT
    2019 AS Year,
    `Country or region` AS Country,
    `Overall rank` AS Happiness_Rank,
    Score AS Happiness_Score,
    `GDP per capita` AS GDP_per_Capita,
    `Social support` AS Social_Support,
    `Healthy life expectancy` AS Health,
    `Freedom to make life choices` AS Freedom,
    Generosity
FROM happiness_2019;

SELECT * FROM happiness_all_years;

##1)Find countries with Happiness Score above 7
SELECT Year, Country, Happiness_Score
FROM happiness_all_years
WHERE Happiness_Score > 7
ORDER BY Happiness_Score DESC;

##2)Top 10 Happiness Scores Across All Years
SELECT Year, Country, Happiness_Score
FROM happiness_all_years
ORDER BY Happiness_Score DESC
LIMIT 10;

##3)Find average Happiness Score for each year
SELECT Year,
       ROUND(AVG(Happiness_Score), 2) AS Average_Happiness
FROM happiness_all_years
GROUP BY Year
ORDER BY Year;

##4)Find highest Happiness Score in each year
SELECT Year,MAX(Happiness_Score) AS Highest_Happiness
FROM happiness_all_years
GROUP BY Year
ORDER BY Year;

##5)Find countries with Happiness Score between 6 and 7
SELECT Year, Country, Happiness_Score
FROM happiness_all_years
WHERE Happiness_Score BETWEEN 6 AND 7
ORDER BY Happiness_Score DESC;

##6)Count countries recorded in each year
SELECT
    Year,
    COUNT(*) AS Total_Records
FROM happiness_all_years
GROUP BY Year
ORDER BY Year;

##7)Find countries with highest Freedom scores
SELECT Year, Country, Freedom
FROM happiness_all_years
ORDER BY Freedom DESC
LIMIT 10;

##8)Compare Happiness Scores in 2016 and 2017
SELECT
    a.Country,
    a.`Happiness Score` AS Happiness_2016,
    b.`Happiness.Score` AS Happiness_2017
FROM happiness_2016 AS a
INNER JOIN happiness_2017 AS b
    ON a.Country = b.Country;
    
##9)Compare Happiness Scores in 2018 and 2019
    SELECT
    a.`Country or region` AS Country,
    a.Score AS Happiness_2018,
    b.Score AS Happiness_2019
FROM happiness_2018 AS a
INNER JOIN happiness_2019 AS b
    ON a.`Country or region` = b.`Country or region`;
    
    ##10)Find countries whose Happiness Score increased from 2016 to 2017
    SELECT
    a.Country,
    a.`Happiness Score` AS Happiness_2016,
    b.`Happiness.Score` AS Happiness_2017,
    ROUND(
        b.`Happiness.Score` - a.`Happiness Score`, 2
    ) AS Score_Change
FROM happiness_2016 AS a
INNER JOIN happiness_2017 AS b
    ON a.Country = b.Country
WHERE b.`Happiness.Score` > a.`Happiness Score`
ORDER BY Score_Change DESC;

##11)Find the year with the highest average Happiness Score
SELECT
    Year,
    ROUND(AVG(Happiness_Score), 2) AS Average_Happiness
FROM happiness_all_years
GROUP BY Year
HAVING AVG(Happiness_Score) = (
    SELECT MAX(Yearly_Average)
    FROM (
        SELECT AVG(Happiness_Score) AS Yearly_Average
        FROM happiness_all_years
        GROUP BY Year
    ) AS yearly_scores
);

##12)Find countries present in 2016 but not in 2017
SELECT a.Country
FROM happiness_2016 AS a
LEFT JOIN happiness_2017 AS b
    ON a.Country = b.Country
WHERE b.Country IS NULL;

##13)Find countries with high Social Support
SELECT Year, Country, Social_Support
FROM happiness_all_years
WHERE Social_Support > 1
ORDER BY Social_Support DESC
LIMIT 10;

##14)Find the lowest Happiness Score in each year
SELECT Year,
       MIN(Happiness_Score) AS Lowest_Happiness
FROM happiness_all_years
GROUP BY Year
ORDER BY Year;

##15)Find distinct countries in the combined dataset
SELECT DISTINCT Country
FROM happiness_all_years
ORDER BY Country;

