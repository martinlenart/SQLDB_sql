USE musicefc;
GO

CREATE OR ALTER VIEW dbo.vw_summary AS

SELECT 'Antal grupper' [Rubrik], COUNT (MusicGroupId) [Antal] FROM dbo.MusicGroups
UNION
SELECT 'Antal album', COUNT (AlbumId) FROM dbo.Albums
UNION 
SELECT 'Antal artister', COUNT (ArtistId) FROM dbo.Artists;

GO

--using the View
SELECT * FROM dbo.vw_summary;