USE musicefc;
GO

--Create some users
CREATE USER Hermione WITHOUT LOGIN;
CREATE USER Albus WITHOUT LOGIN;
CREATE USER Gandalf WITHOUT LOGIN;

ALTER ROLE musicefcUsers ADD MEMBER Hermione;
ALTER ROLE musicefcUsers ADD MEMBER Albus;
ALTER ROLE musicefcUsers ADD MEMBER Gandalf;

--Impersonate the users
EXECUTE AS USER = 'Albus';  -- try all different, Albus, Gandalf, Hermoine

--This works
SELECT * FROM usr.vwArtists;

--But not this
SELECT * FROM dbo.Artists;

--Go back to being myslef
REVERT;