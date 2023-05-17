-- Exercise Advanced Query, Correlated Queries
-- Using the musicefc database, create a View that shows every column from MusicGroup together 
-- with most sold AlbumId and most sold number of copies of that album.

-- Most sold album Alt 1 Subquery, using TOP 1 to find high runner
CREATE OR ALTER VIEW dbo.vw_MusicGroups1
AS
SELECT  m.*, 
        
        (SELECT TOP 1 AlbumId FROM dbo.Albums hr 
         WHERE m.MusicGroupId = hr.csMusicGroupMusicGroupId 
         ORDER BY CopiesSold DESC) [High runner AlbumId],
        
        (SELECT TOP 1 CopiesSold FROM dbo.Albums hr 
         WHERE m.MusicGroupId = hr.csMusicGroupMusicGroupId 
         ORDER BY CopiesSold DESC) [High runner copies]
FROM MusicGroups m

GO

-- Most sold album Alt 2 SubQuery,  using MAX() to find high runner
CREATE OR ALTER VIEW dbo.vw_MusicGroups2
AS
SELECT m.*, a.AlbumId [High runner AlbumId], a.CopiesSold [High runner copies] FROM dbo.MusicGroups m
INNER JOIN dbo.Albums a ON m.MusicGroupId = a.csMusicGroupMusicGroupId
WHERE a.CopiesSold = (
    SELECT mg.hrcopies FROM (
    SELECT csMusicGroupMusicGroupId, MAX(CopiesSold) [hrcopies] FROM dbo.Albums
    WHERE csMusicGroupMusicGroupId = m.MusicGroupId
    GROUP BY csMusicGroupMusicGroupId) mg
)

GO

--Test the views
SELECT * FROM dbo.vw_MusicGroups1;
SELECT * FROM dbo.vw_MusicGroups2;



--NOTE:
--Steps taken to reach Alt 2
-- Step 1: find max copies sold per group
SELECT csMusicGroupMusicGroupId, MAX(CopiesSold) [hrcopies] FROM dbo.Albums
GROUP BY csMusicGroupMusicGroupId;

-- Step 2: Isolate the Scalar (nr of copies
SELECT mg.hrcopies FROM (
    SELECT csMusicGroupMusicGroupId, MAX(CopiesSold) [hrcopies] FROM dbo.Albums
    GROUP BY csMusicGroupMusicGroupId) mg

-- Step3: Put it together and add a filter in the subquery to match each MusicGroupId from main query
SELECT m.*, a.AlbumId [High runner AlbumId], a.CopiesSold [High runner copies] FROM dbo.MusicGroups m
INNER JOIN dbo.Albums a ON m.MusicGroupId = a.csMusicGroupMusicGroupId
WHERE a.CopiesSold = (
    SELECT mg.hrcopies FROM (
    SELECT csMusicGroupMusicGroupId, MAX(CopiesSold) [hrcopies] FROM dbo.Albums
    WHERE csMusicGroupMusicGroupId = m.MusicGroupId
    GROUP BY csMusicGroupMusicGroupId) mg
)
