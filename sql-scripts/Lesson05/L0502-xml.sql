USE friends;
GO

--Get full detail of a friend in XML
SELECT f.FriendId "@FriendId", f.FirstName "FirstName", f.LastName "LastName", 
    a.Country "Country", CONCAT_WS(' ', p.Name, 'the happy', p.AnimalKind) "Pet"
FROM dbo.friend f
INNER JOIN dbo.Address a
ON f.AddressId = a.AdressId
INNER JOIN dbo.Pet p
ON f.FriendId = p.FriendId
FOR XML PATH ('Friend');

--Transfer the file to SQL Server for reading
--   1. Click on the result so it opens up in a new Azure tab
--   2. save the tab as an xml file, friends2.xml. Make sure you do save as.. and select XML format
--   3. open a terminal in the directory of your xml file on the computer
--   4. copy the image file from your computer into the docker container: 
--         docker cp friends2.xml sql2022container:/usr/images/

