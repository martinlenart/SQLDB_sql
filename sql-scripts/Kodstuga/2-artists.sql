USE musicefc;
GO

--List all artists
SELECT * FROM dbo.Artists; 

--List only artists with a Birthday
SELECT ArtistId, FirstName, LastName FROM dbo.Artists WHERE Birthday IS NOT NULL; 

--List all artists Age, oldest first
--Use DATEDIFF, YEAR and GETDATE
SELECT ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) FROM dbo.Artists WHERE Birthday IS NOT NULL
ORDER BY 4 DESC; 

--List Oldest Age, Youngest Age, Average Age of all artists
SELECT MAX (DATEDIFF(year, Birthday, GETDATE())), MIN (DATEDIFF(year, Birthday, GETDATE())), AVG (DATEDIFF(year, Birthday, GETDATE()))
FROM dbo.Artists;

--List all artists born between 19530101 and 19530531
SELECT ArtistId, FirstName, LastName, Birthday FROM dbo.Artists 
WHERE BirthDay BETWEEN '19530101' AND '19530531'; 

--Declare variables, assign them in a select and list oldest and youngest artist
DECLARE @young INT, @old INT
SELECT @old = MAX (DATEDIFF(year, Birthday, GETDATE())), @young = MIN (DATEDIFF(year, Birthday, GETDATE()))
FROM dbo.Artists;

SELECT ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) FROM dbo.Artists 
WHERE DATEDIFF(year, Birthday, GETDATE()) IN (@young, @old)
ORDER BY 4;

--List all the Artists with the average age of all artists, with a listname starting with 'T'
DECLARE @average INT
SELECT @average = AVG (DATEDIFF(year, Birthday, GETDATE()))
FROM dbo.Artists;

SELECT ArtistId, FirstName, LastName, DATEDIFF(year, Birthday, GETDATE()) FROM dbo.Artists 
WHERE DATEDIFF(year, Birthday, GETDATE()) = @average AND LastName LIKE 'T%'

