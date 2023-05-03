USE sakila;
GO

--let's create a full text indext from title and description
SELECT * from dbo.film;

--1. Create a full text catalog
CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;

--2. Create a full text index
CREATE FULLTEXT INDEX ON dbo.film  
(   
  [title] Language 1033,  
  [description] Language 1033       
)   
--Copy the primary key index name from dbo.film
KEY INDEX PK__film__349764A8FBB0AB03 ON ftCatalog;
GO 

--remove it
--DROP FULLTEXT INDEX ON dbo.film; 
--DROP FULLTEXT CATALOG ftCatalog;
SELECT * from sys.fulltext_catalogs;
SELECT * from sys.fulltext_indexes;
SELECT * from sys.fulltext_index_columns;

--It will take some seconds then we can look at the content of a full text index
SELECT * FROM sys.dm_fts_index_keywords(DB_ID('sakila'), OBJECT_ID('dbo.film'));
