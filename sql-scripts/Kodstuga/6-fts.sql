USE musicefc;
GO

--1. Create a full text catalog
CREATE FULLTEXT CATALOG ftCatalog AS DEFAULT;

--2. Create a unique index in the table of the FullText Search 
CREATE UNIQUE INDEX Albums_FTS_idx ON dbo.Albums(AlbumId);

--2. Create a full text index ontop of the unique index created in Step 2.
CREATE FULLTEXT INDEX ON dbo.Albums  
(   
  [Name] Language 1033       
)   
--Copy the primary key index name from dbo.film
KEY INDEX Albums_FTS_idx ON ftCatalog;
GO 

SELECT * from sys.fulltext_catalogs;
SELECT * from sys.fulltext_indexes;
SELECT * from sys.fulltext_index_columns;

--It will take some seconds then we can look at the content of a full text index
SELECT * FROM sys.dm_fts_index_keywords(DB_ID('musicefc'), OBJECT_ID('dbo.Albums'));

--remove it
--DROP FULLTEXT INDEX ON dbo.Albums; 
--DROP FULLTEXT CATALOG ftCatalog;
--DROP INDEX Albums_FTS_idx ON dbo.Albums;