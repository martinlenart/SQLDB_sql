USE friends;
GO

--using SELECT INTO contruct and a temp table let's me avoid declaring a table separatly
SELECT friend.* 
INTO #fromJSON
FROM
-- Docker container
OPENROWSET(BULK N'/usr/images/friends3.json', SINGLE_CLOB) AS json

-- SQL Server Express
-- OPENROWSET(BULK N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\Backup\friends3.json', SINGLE_CLOB) AS json

 CROSS APPLY OPENJSON(BulkColumn)
 WITH(
    FriendId int, FirstName NVARCHAR(200), LastName NVARCHAR(200), 
    Country NVARCHAR(200), Pet NVARCHAR(200)) AS friend

SELECT * FROM #fromJSON

DROP TABLE #fromJSON;
