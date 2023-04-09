USE friends;
GO

--Get full detail of a friend in XML
SELECT * 
FROM dbo.friend Friend
INNER JOIN dbo.Address [Address]
ON friend.AddressId = [Address].AdressId
INNER JOIN dbo.Pet Pet
ON Friend.FriendId = Pet.FriendId
FOR XML AUTO


--Example, Write it to an @variable
DECLARE @myXML XML;

--Get full detail of a friend in XML
SET @myXML = (SELECT * 
FROM dbo.friend Friend
INNER JOIN dbo.Address [Address]
ON friend.AddressId = [Address].AdressId
INNER JOIN dbo.Pet Pet
ON Friend.FriendId = Pet.FriendId
FOR XML AUTO);

SELECT @myXML;

--you can store it in an xml file using azure data studio
