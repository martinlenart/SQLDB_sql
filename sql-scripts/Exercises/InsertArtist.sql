USE musicefc;
GO

--Let's first create an application Error log table
DROP TABLE IF EXISTS dbo.ErrorLog; --Housecleaning for the example     
CREATE TABLE dbo.ErrorLog(
    err_nr INT,
    err_msg NVARCHAR(400),
    err_line INT,
    err_sev INT);
GO

--Create a stored procedure that inserts an Artist into the dbo.artist table
--Putting it together, return code, default parameters and output parameters with
--Transactions and Error Handling and logging
CREATE OR ALTER PROCEDURE dbo.usp_InsertArtist
    @FirstName NVARCHAR(200) = NULL,
    @LastName NVARCHAR(200) = NULL,
    --Use an output variable to return number of rows in the dataset
    @Count INT OUTPUT,
    
    --Parameters with default values
    @BirthDay DATETIME = NULL,
    @MusicGroupId UNIQUEIDENTIFIER = NULL  AS

    SET NOCOUNT ON;

    DECLARE @retCode INT = 0;
    SET @Count = 0;

    BEGIN TRANSACTION    
        BEGIN TRY
            INSERT INTO dbo.Artists VALUES 
                ('hello', @FirstName, @LastName, @BirthDay, @MusicGroupId); -- will trigger ArtistId error

            --@@ROWCOUNT always number of rows affected in last statement
            SET @Count = @@ROWCOUNT; 
            COMMIT;

        END TRY       
        BEGIN CATCH

            ROLLBACK

            --Logg the error   
            INSERT INTO dbo.ErrorLog (err_nr, err_msg, err_line, err_sev)
            VALUES (ERROR_NUMBER(), ERROR_MESSAGE(), ERROR_LINE(), ERROR_SEVERITY())
            
            --Notify user of stored procedure that it did not succeed
            SET @retCode = 1
            
            --or THROW the same error again to a client
            --;THROW
        END CATCH;
    RETURN @retCode;
GO