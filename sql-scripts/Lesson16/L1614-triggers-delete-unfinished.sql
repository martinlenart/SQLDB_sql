USE goodfriendsefc;
GO

--UPDATE Triggers

--INSTEAD OF trigger fires before any constraint check, e.g., not null in FriendId
--I can use this trigger to create a GUID
CREATE OR ALTER TRIGGER trInsteadUpdateFriends
ON [dbo].[tmpFriends] INSTEAD OF UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM inserted;
 
    PRINT 'About to update ' + CAST (@Count AS NVARCHAR) + ' friends';

    UPDATE [dbo].[tmpFriends]
    SET 
    WHERE [dbo].[tmpFriends].FriendId IN (SELECT FriendId From inserted);

END
GO

--AFTER trigger fires after the row is inserted
--I can use this trigger to UPDATE any value in the database. For example replace NULL in an email adress
CREATE OR ALTER TRIGGER trAfterUpdateFriends
ON [dbo].[tmpFriends] AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Count INT;
    SELECT @Count = COUNT(*) FROM inserted;
 
    PRINT CAST (@Count AS NVARCHAR) + ' friends updated';
END
GO

--Let's update some values
UPDATE [dbo].[tmpFriends]
SET Firstname = 'Hairy'
WHERE FirstName = 'Harry' AND LastName = 'Potter';

SELECT * FROM [dbo].[tmpFriends] WHERE LastName = 'Potter';


--List all triggers
SELECT  name, object_id, schema_id, parent_object_id, type_desc, create_date, modify_date, is_published  
FROM sys.objects  
WHERE type = 'TR';   