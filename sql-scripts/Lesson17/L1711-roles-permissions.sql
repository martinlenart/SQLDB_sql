USE musicefc;
GO

EXECUTE AS USER = 'Peregrin'; 
--EXECUTE AS USER = 'Albus'; 

IF (SELECT IS_MEMBER('musicefcUsers')) = 1
       SELECT 'Member of the musicefcUsers';


--note, this query only returns rows for tables where the user has SOME rights
SELECT  TABLE_SCHEMA + '.' + TABLE_NAME AS tableName,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'SELECT') AS AllowSelect,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'INSERT') AS AllowInsert,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'DELETE') AS AllowDelete,
        HAS_PERMS_BY_NAME(TABLE_SCHEMA + '.' + TABLE_NAME, 'OBJECT', 'UPDATE') AS AllowUpdate
FROM    INFORMATION_SCHEMA.TABLES;

REVERT;

--Cleanup
DROP USER Hermione;
DROP USER Albus;
DROP USER Gandalf;
DROP USER Peregrin;
DROP ROLE musicefcUsers;