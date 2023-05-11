USE musicefc;
GO

--List all albums
SELECT * FROM dbo.Albums; 

--List only AlbumId, Name, ReleaseYear
SELECT AlbumId, Name, ReleaseYear FROM dbo.Albums; 

--List only AlbumId, Name, ReleaseYear - Order by ReleaseYear, latest first
SELECT AlbumId, Name, ReleaseYear FROM dbo.Albums
ORDER BY 3 DESC;

--List distinct Album names
SELECT DISTINCT [Name] FROM dbo.Albums;

--Count the number of albums
SELECT COUNT(*) FROM dbo.Albums;

--Count the number of distinct album names
SELECT COUNT(DISTINCT [Name]) FROM dbo.Albums;

--Nr of copies sold of all the albums
SELECT SUM(CopiesSold) FROM dbo.Albums;

--List distinct album names with 'Prince' in the Name
SELECT DISTINCT [Name] FROM dbo.Albums
WHERE Name LIKE '%Prince%';

--Replace the 'Prince'to 'Princess' of the all the abum named 'The Creedence Prince' and 'The Clearwater Prince'
UPDATE dbo.Albums
SET Name = REPLACE (Name, 'Prince', 'Princess')
WHERE Name IN ('The Creedence Prince', 'The Clearwater Prince');

--Add Albums without a music group, 
--  'Great Sound of Whales', released 2023, 5 copies sold
--  'Great Sound of Trees', released 2022, 20 copies sold
--  'Great Sound of Penguins', released 2021, 2 copies sold
--Use NEWID() to create a unique identifier
INSERT INTO dbo.Albums (AlbumId, Name, ReleaseYear, CopiesSold)
VALUES (NEWID(), 'Great Sound of Whales', 2023, 5),
       (NEWID(), 'Great Sound of Trees', 2022, 20),
       (NEWID(), 'Great Sound of Penguins', 2021, 2)

--List all albums without a MusicGroup
SELECT * FROM dbo.Albums WHERE csMusicGroupMusicGroupId IS NULL;

--Delete all albums without a MusicGroup
DELETE FROM dbo.Albums WHERE csMusicGroupMusicGroupId IS NULL;


--Nr of copies sold per albums, ordre by top sales
SELECT AlbumId, Name, SUM(CopiesSold) FROM dbo.Albums
GROUP BY AlbumId, Name
ORDER BY 3 DESC;

--List only the 1st top sales album
SELECT TOP 1 AlbumId, Name, SUM(CopiesSold) FROM dbo.Albums
GROUP BY AlbumId, Name
ORDER BY 3 DESC;
