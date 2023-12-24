-- Pulling Up All The Data 

SELECT *
FROM dbo.Adult_Income_Census

-- Finding Out the Average Level of Education Attained by Age

SELECT Age, AVG(Education_Number) AS Average_Education_Level
FROM dbo.Adult_Income_Census
GROUP BY Age
ORDER BY Age

-- Finding the Overall Education Level of All 27,000+ Americans In The Census of 1994

SELECT AVG(Education_Number) AS Average_1994_American_Education_Level
FROM dbo.Adult_Income_Census

-- Dissecting Average Education Level of 1994 Americans by Gender As Well

SELECT Sex AS Gender, AVG(Education_Number) AS Average_1994_American_Education_Level
FROM dbo.Adult_Income_Census
GROUP BY Sex

-- Work Smarter, Not Harder: Is Hours Worked per Week Related to Income?

SELECT Hours_per_Week AS Hours_Worked_Per_Week, Sex AS Gender, Income
FROM dbo.Adult_Income_Census
GROUP BY Hours_per_Week, Sex, Income
ORDER BY Hours_per_Week 

-- Identifying The Most In-Demand Occupations of The Time

SELECT Occupation, COUNT(Occupation) AS Total_Occupied
FROM dbo.Adult_Income_Census
GROUP BY Occupation
ORDER BY COUNT(Occupation) DESC

-- In the US, the Retirement Age is 65, so let's Mark People Over 65 As "N/A" For The "Well-Earning" Category

UPDATE dbo.Adult_Income_Census
SET
    Well_Earning = 'N/A'
WHERE Age >= 65
GO

-- Now, Let's Check This Latest Update^ Out!

SELECT *
FROM dbo.Adult_Income_Census
ORDER BY Age DESC

-- Work Class Most Abundant

SELECT Work_Class, COUNT(Work_Class) AS Amount_Employed_In_Class
FROM dbo.Adult_Income_Census
GROUP BY Work_Class
ORDER BY COUNT(Work_Class) DESC

-- Exploring The Demographics of People In The "Without-Pay" and Especially The "Never-Worked" Class

SELECT Age, Education, Education_Number, Marital_Status, Race, Sex AS Gender, Work_Class
FROM dbo.Adult_Income_Census
WHERE Work_Class = 'Without-pay'
OR Work_Class = 'Never-worked'
GROUP BY Age, Education, Education_Number, Marital_Status, Race, Sex, Work_Class
ORDER BY Work_Class

-- Exploring The Correlation Between Average Education Level & Poor Work Situation

SELECT AVG(Education_Number) AS Average_Education_Level, Work_Class
FROM dbo.Adult_Income_Census
WHERE Work_Class = 'Without-pay'
OR Work_Class = 'Never-worked'
GROUP BY Work_Class
ORDER BY Work_Class

-- Are Hours Worked per Week Related to Education Level? (Work Smarter, Not Harder)

SELECT Hours_per_Week AS Hours_Worked_Per_Week, AVG(Education_Number) AS Average_Education_Level
FROM Adult_Income_Census
GROUP BY Hours_per_Week
ORDER BY Hours_per_Week

-- Hours Worked per Week by Occupation

SELECT Occupation, AVG(Hours_per_Week) AS Average_Hours_Worked_Per_Week
FROM dbo.Adult_Income_Census
WHERE Occupation != '?'
GROUP BY Occupation
ORDER BY Average_Hours_Worked_Per_Week

-- FOR FUN: Minimum Total Hours Worked by People in The Study in 1994

SELECT SUM((Hours_per_Week)*52) AS Total_Hours_Worked_By_All
FROM dbo.Adult_Income_Census

-- Looking at American Immigrant Demographics in 1994

SELECT Native_Country, COUNT(Native_Country) AS Count_of_Immigrants
FROM dbo.Adult_Income_Census
WHERE Native_Country != 'United-States'
AND Native_Country != '?'
GROUP BY Native_Country
ORDER BY COUNT(Native_Country) DESC

-- Having a Bachelor's Degree Means an Education_Number of 13, So Adding a Classification for Highly Educated

SELECT Age, Education, Education_Number,
CASE
WHEN Education_Number >= 13 THEN 'Highly Educated'
WHEN Education_Number >= 9 THEN 'High School Graduate'
WHEN Education_Number < 9 THEN 'Low Education'
END AS Education_Classification
FROM dbo.Adult_Income_Census
WHERE Age >= 22
ORDER BY Age

SELECT Age, Bio, Hours_per_Week,
CASE
WHEN Hours_per_Week >= 60 THEN 'Burned-Out!'
WHEN Hours_per_Week >=50 THEN 'Over-Working'
WHEN Hours_per_Week >= 40 THEN 'Working Full-Time'
WHEN Hours_per_Week >= 25 THEN 'Working'
WHEN Hours_per_Week >= 10 THEN 'Working Part-Time'
WHEN Hours_per_Week < 10 THEN 'Working Very Little'
WHEN Hours_per_Week = 0 THEN 'Not Working'
END AS Hours_Worked_Classification
FROM dbo.Adult_Income_Census
WHERE Age >= 18
ORDER BY Hours_per_Week

-- ALTER TABLE Practice!

ALTER TABLE [dbo].[Adult_Income_Census]
    ADD [practice_column] int
GO new_column INT AFTER Age

-- The "Race" Column is NOT Needed Now, so let's Drop it

ALTER TABLE [dbo].[Adult_Income_Census]
    DROP COLUMN [Race]
GO

-- Confirming
SELECT *
FROM dbo.Adult_Income_Census