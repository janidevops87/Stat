 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_IMPORT_ImportApply_XLS]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_IMPORT_ImportApply_XLS]
			PRINT 'Dropping Procedure: spi_IMPORT_ImportApply_XLS'
	END

PRINT 'Creating Procedure: spi_IMPORT_ImportApply_XLS'
GO

CREATE PROCEDURE [dbo].[spi_IMPORT_ImportApply_XLS]
/******************************************************************************
**		File: spi_IMPORT_ImportApply_XLS.sql
**		Name: spi_IMPORT_ImportApply_XLS
**		Desc: Web Registry
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 12/10/2010
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		12/10/2010	ccarroll	initial
*******************************************************************************/
AS

SET NOCOUNT ON
	
DECLARE @ID       int, 
        @IDENTITY int, 
		@IMPORTLOGID int,
        @Addr1       varchar(255), 
        @Addr2       varchar(255),
        @City        varchar(255), 
        @State       varchar(255), 
        @Zip         varchar(255),
        @GUID		 varchar(255),
        @Donor       varchar(255),
        @DonorTF     bit = 1


SELECT @IMPORTLOGID = [RegistryImportLogID]
	FROM RegistryImportLog
	WHERE upper(RunStatus) = 'LOADING';

DECLARE cIMPORT CURSOR FOR 
	SELECT Import_XLS.Import_XLSID FROM Import_XLS

OPEN cIMPORT

FETCH NEXT FROM cIMPORT INTO @id 

WHILE @@FETCH_status = 0
	BEGIN
	    BEGIN transaction IMPORT
	    
	    

		INSERT Registry (
							[DOB],
							[FirstName],
							[MiddleName],
							[LastName],
							[DMVDonor],
							[Donor],
							[DonorConfirmed],
							[OnlineRegDate],
							[DeleteFlag],
							[LastModified], 
							[CreateDate] 
						)
	    SELECT 
							CASE ISDATE(DateOfBirth) WHEN 0 THEN NULL ELSE CONVERT(datetime, DateOfBirth) END AS DOB, 
							CASE WHEN LEN(ltrim(rtrim(FirstName))) > 20 THEN LEFT(ltrim(rtrim(FirstName)), 17) + '...' ELSE ltrim(rtrim(FirstName))END AS FirstName,
							CASE WHEN LEN(ltrim(rtrim(MiddleName))) > 20 THEN LEFT(ltrim(rtrim(MiddleName)), 17) + '...' ELSE ltrim(rtrim(MiddleName))END AS MiddleName,
							CASE WHEN LEN(ltrim(rtrim(LastName))) > 20 THEN LEFT(ltrim(rtrim(LastName)), 17) + '...' ELSE ltrim(rtrim(LastName))END AS LastName,
							0 AS DMVDonor,
							@DonorTF AS Donor,
							@DonorTF AS DonorConfirmed,
							GETDATE() AS OnlineRegDate,
							0 AS DeleteFlag,
							GETDATE() AS LastModified,
							GETDATE() AS CreateModified
		FROM IMPORT_XLS
		WHERE IMPORT_XLS.IMPORT_XLSID = @ID;
		SELECT @IDENTITY = @@IDENTITY
		SELECT	
							@Addr1 = Left(ltrim(rtrim([Address1])), 40), 
							@Addr2 = Left(ltrim(rtrim([Address2])), 20), 
							@City = Left(ltrim(rtrim([City])), 25),  
							@State = Left(ltrim(rtrim([State])), 2),  
							@Zip = Left(ltrim(rtrim([Zip])), 10),
							@GUID = ltrim(rtrim([GUID]))
		FROM IMPORT_XLS
		WHERE IMPORT_XLS.IMPORT_XLSID = @ID;   

IF isnull(@Addr1,'') + isnull(@Addr2,'') + isnull(@City,'') + isnull(@State,'') + isnull(@Zip,'') <> ''
BEGIN
		INSERT REGISTRYADDR (
							[RegistryID],
							[AddrTypeID],
							[Addr1],
							[Addr2],
							[City],
							[State],
							[Zip],
							[LastModified],
							[CreateDate]
							)
		VALUES			(
							@IDENTITY,
							1,
							@Addr1,
							@Addr2,
							@City,
							@State,
							@Zip,
							GETDATE(),
							GETDATE()
						)
END
		
		INSERT RegistryGUID (
							[RegistryImportLogID],
							[RegistryID],
							[GUID],
							[LastModified],
							[CreateDate]
							)
		VALUES			(
							@IMPORTLOGID,
							@IDENTITY,
							CAST(@GUID AS uniqueidentifier),
							GETDATE(),
							GETDATE()
						)

	   COMMIT TRANSACTION IMPORT

	   FETCH NEXT FROM cIMPORT into @id
	END

CLOSE cIMPORT
DEALLOCATE cIMPORT

GO