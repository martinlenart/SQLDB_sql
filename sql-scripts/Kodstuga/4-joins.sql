USE musicefc;
GO

--List all Albums per MusicGroup
SELECT * FROM dbo.MusicGroups g
INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId;  

--List all the Artist in a group with particular MusicGroupId
SELECT * FROM dbo.MusicGroups g
INNER JOIN dbo.Artists a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
WHERE g.MusicGroupId =  '0ec52d03-3ae6-407a-bdb7-08db513f5b25'; 


--List total album copies sold per MusicGroup, order by top sales
SELECT g.MusicGroupId, g.Name, SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
GROUP BY g.MusicGroupId, g.Name
ORDER BY 2 DESC;

--List album copies sold per Album, per MusicGroup, order by group, top sales
SELECT g.MusicGroupId, g.Name [group], a.AlbumId, a.Name [album], SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
GROUP BY g.MusicGroupId, g.Name, a.AlbumId, a.Name
ORDER BY 1,2,5 DESC;

--List album copies sold per Album, per MusicGroup, order by top sales - use WITH ROLLUP
SELECT g.MusicGroupId, g.Name [group], a.AlbumId, a.Name [album], SUM (a.CopiesSold) [copies sold] FROM dbo.MusicGroups g
INNER JOIN dbo.Albums a ON g.MusicGroupId = a.csMusicGroupMusicGroupId
GROUP BY g.MusicGroupId, g.Name, a.AlbumId, a.Name WITH ROLLUP
ORDER BY 1,2,5 DESC;

