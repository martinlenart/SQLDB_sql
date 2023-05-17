USE musicefc;
GO

--QUESTION: List all Artists from the MusicGroup has the sold most copies
--By subquery
--Step1: List total album copies sold per MusicGroup, order by top sales, take top row
SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
GROUP BY g.MusicGroupId, g.Name
ORDER BY 3 DESC;

--Step2: Isolate the scalar MusicGroupId by using subquery
SELECT s.MusicGroupId FROM (
    SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
    INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
    GROUP BY g.MusicGroupId, g.Name
    ORDER BY 3 DESC) s;

--Step3: Find all Artists in the music group with MusicGroupId isolated in Step2
--This is the SINGEL SQL ANSWER
SELECT * FROM dbo.Artists
WHERE csMusicGroupMusicGroupId = (
    SELECT s.MusicGroupId FROM (
    SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
    INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
    GROUP BY g.MusicGroupId, g.Name
    ORDER BY 3 DESC) s
)

--By CTE
--This is the SINGEL SQL ANSWER
--Step1: Set name and SQL query for the CTE finding top sales group
WITH group_hi_sale AS (
    SELECT TOP 1 g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
    INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
    GROUP BY g.MusicGroupId, g.Name
    ORDER BY 3 DESC
)
--Step2: Set the CTE Main query, showing members in the group from result in Step 1
SELECT * FROM dbo.Artists
WHERE csMusicGroupMusicGroupId = (SELECT MusicGroupId FROM group_hi_sale);


--QUESTION: List all MusicGroups with the oldest members
--By subquery
--Step1: Find the oldest members age
--Use DATEDIFF, YEAR and GETDATE
SELECT TOP 1 ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) [age] FROM dbo.Artists WHERE Birthday IS NOT NULL
ORDER BY 4 DESC; 

--Step2: Isolate the scalar Age by using subquery
SELECT s.Age FROM (
    SELECT TOP 1 ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) [age] 
    FROM dbo.Artists 
    WHERE Birthday IS NOT NULL
ORDER BY 4 DESC) s;

--Step 3: Find the music groups where artists has the age isolated in Step2
--This is the SINGEL SQL ANSWER
SELECT DISTINCT g.* FROM dbo.MusicGroups g
INNER JOIN dbo.Artists a ON g.MusicGroupId = a.csMusicGroupMusicGroupId 
WHERE DATEDIFF(year, Birthday, GETDATE()) = (
    SELECT s.Age FROM (
    SELECT TOP 1 ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) [age] 
    FROM dbo.Artists 
    WHERE Birthday IS NOT NULL
    ORDER BY 4 DESC) s
)

--By CTE
--This is the SINGEL SQL ANSWER
--Step1: Set name and SQL query for the CTE to find the oldest members age
WITH oldest_fart AS (
    SELECT TOP 1 ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) [age] 
    FROM dbo.Artists WHERE Birthday IS NOT NULL
    ORDER BY 4 DESC
)
--Step2: Set the CTE Main query, showing members in the group from result in Step 1
SELECT DISTINCT g.* FROM dbo.MusicGroups g
INNER JOIN dbo.Artists a ON g.MusicGroupId = a.csMusicGroupMusicGroupId 
WHERE DATEDIFF(year, Birthday, GETDATE()) = (SELECT age FROM oldest_fart);


