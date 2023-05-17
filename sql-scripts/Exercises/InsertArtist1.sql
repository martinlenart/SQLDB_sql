USE musicefc;
GO

--Litle helper function for PRINT
CREATE OR ALTER FUNCTION dbo.udf_ExecutionSuccess(@ret_code INT, @rows INT)
RETURNS NVARCHAR(200) AS
BEGIN
    DECLARE @sRET NVARCHAR(200);
    IF @ret_code = 0  
        SET @sRet = 'Procedure executed successfully. ' + CAST(@rows AS VARCHAR) + ' friends found';
    ELSE
        SET @sRet = 'Error executing stored procedure';

    RETURN @sRET;
END;
GO

--Lets execute InsertArtist
DECLARE @ret_code INT;
DECLARE @rows INT;

EXEC @ret_code = dbo.usp_InsertArtist 'John', 'Doe',  @rows;
PRINT dbo.udf_ExecutionSuccess(@ret_code, @rows); 

SELECT * FROM dbo.Artists WHERE LastName = 'Doe'; 