IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertRegistryDlaResponse]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertRegistryDlaResponse];
			PRINT 'Dropping Procedure: InsertRegistryDlaResponse';
	END

PRINT 'Creating Procedure: InsertRegistryDlaResponse';
GO

CREATE PROCEDURE [dbo].[InsertRegistryDlaResponse]
(
	@RequestDOB DATETIME = NULL,
	@RequestFirstName VARCHAR(20) = NULL,
	@RequestMiddleName VARCHAR(20) = NULL,
	@RequestLastName VARCHAR(25) = NULL,
	@RequestCity VARCHAR(25) = NULL,
	@RequestState VARCHAR(2) = NULL,
	@RequestZip VARCHAR(10) = NULL,
	@RequestDateTime DATETIME = NULL,
	@ResponseDateTime DATETIME = NULL,
	@ItemCount INT = NULL,
	@ErrorCount INT = NULL
)
/******************************************************************************
**		File: InsertRegistryDlaResponse.sql
**		Name: InsertRegistryDlaResponse
**		Desc: Donate Life America Registry
**
**		Called by:   
**              
**
**		Auth: Mike Berenson
**		Date: 10/04/2016
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------------
**      10/04/2016	Mike Berenson	Initial Stored Procedure Creation
*******************************************************************************/
AS
	SET NOCOUNT ON;

	INSERT INTO [RegistryDlaResponse]
	(
		[RequestDOB],
		[RequestFirstName],
		[RequestMiddleName],
		[RequestLastName],
		[RequestCity],
		[RequestState],
		[RequestZip],
		[RequestDateTime],
		[ResponseDateTime],
		[ItemCount],
		[ErrorCount],
		[CreateDate],
		[LastModified],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RequestDOB,
		@RequestFirstName,
		@RequestMiddleName,
		@RequestLastName,
		@RequestCity,
		@RequestState,
		@RequestZip,
		@RequestDateTime,
		@ResponseDateTime,
		@ItemCount,
		@ErrorCount,
		GETDATE(), --@CreateDate,
		GETDATE(), --@LastModified,
		1 --Create @AuditLogTypeID
	);

	SELECT [RegistryDlaResponseID],
		[RequestDOB],
		[RequestFirstName],
		[RequestMiddleName],
		[RequestLastName],
		[RequestCity],
		[RequestState],
		[RequestZip],
		[RequestDateTime],
		[ResponseDateTime],
		[ItemCount],
		[ErrorCount]

	FROM RegistryDlaResponse
	WHERE  RegistryDlaResponseID = SCOPE_IDENTITY();

	RETURN @@Error;
GO