USE friends;
GO

-- Dynamic SQL
-- A very bad idea from SQLServer Security Perspective
-- https://learn.microsoft.com/en-us/sql/relational-databases/security/sql-server-security-best-practices?view=sql-server-ver16#sql-injection-risks
EXEC ('SELECT * FROM dbo.Friend;');

DECLARE @UserInput INT = '6';
EXEC ('SELECT * FROM dbo.Friend WHERE FriendId = ' + @UserInput + ';');


