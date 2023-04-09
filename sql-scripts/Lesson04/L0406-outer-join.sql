USE friends;
GO

--Use Outer left join to get the adresses
--Note: Friends with addressId NULL is now part of the result
SELECT * 
FROM dbo.friends f 
LEFT OUTER JOIN dbo.Address a
ON f.AddressId = a.AdressId;

--Use Outer Left join to get the address and pet detail
--Note: Friends with addressId NULL is now part of the result
SELECT * 
FROM dbo.friends f 
LEFT OUTER JOIN dbo.Address a
ON f.AddressId = a.AdressId
INNER JOIN dbo.Pet p
ON f.FriendId = p.FriendId;
