CREATE OR ALTER VIEW dbo.vw_AlbumsSales 
AS

--List total album copies sold per MusicGroup, order by top sales
SELECT m.MusicGroupId, m.Name, SUM(CopiesSold) AS [copies sold] FROM dbo.MusicGroups m
RIGHT OUTER JOIN dbo.Albums a ON m.MusicGroupId = a.csMusicGroupMusicGroupId
GROUP BY m.MusicGroupId, m.Name;


GO

SELECT * FROM dbo.vw_AlbumsSales 
ORDER BY 2 DESC;
