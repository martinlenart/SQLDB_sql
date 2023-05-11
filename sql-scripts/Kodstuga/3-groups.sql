USE musicefc;
GO

--List all MusicGroups
SELECT * FROM dbo.MusicGroups; 

--List all MusicGroups established 1971, 1973 and 1975
SELECT * FROM dbo.MusicGroups WHERE EstablishedYear IN (1971, 1973, 1975) ; 

--List number of groups establist per year. Sort by year
SELECT EstablishedYear, COUNT(MusicGroupId) FROM dbo.MusicGroups
GROUP BY EstablishedYear
ORDER BY 2 DESC;

--List number of groups establist per year. Sort by year List also total number o fgroups using WITH ROLLUP
SELECT EstablishedYear, COUNT(MusicGroupId) FROM dbo.MusicGroups
GROUP BY EstablishedYear WITH ROLLUP
ORDER BY 2 DESC;
