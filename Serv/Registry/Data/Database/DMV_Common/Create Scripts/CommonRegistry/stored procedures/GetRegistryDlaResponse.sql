IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetRegistryDlaResponse]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetRegistryDlaResponse];
	PRINT 'Dropping Procedure: GetRegistryDlaResponse';
END
	PRINT 'Creating Procedure: GetRegistryDlaResponse';
GO

CREATE PROCEDURE [dbo].[GetRegistryDlaResponse]
(
	@RegistryDlaResponseID INT = NULL,
	@RequestFirstName VARCHAR(20) = NULL,
	@RequestLastName VARCHAR(20) = NULL,
	@RequestDOB DATETIME = NULL
)
/******************************************************************************
**		File: GetRegistryDlaResponse.sql
**		Name: GetRegistryDlaResponse
**		Desc:  Donate Life America Registry
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
**		10/04/2016	Mike Berenson	Initial Stored Procedure Creation
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
	SET NOCOUNT ON;

	SELECT TOP 1
		[RegistryDlaResponseID],
		[RequestDOB],
		COALESCE([RequestFirstName], '') AS RequestFirstName,
		COALESCE([RequestMiddleName], '') AS RequestMiddleName,
		COALESCE([RequestLastName], '') AS RequestLastName,
		COALESCE([RequestCity], '') AS RequestCity,
		COALESCE([RequestState], '') AS RequestState,
		COALESCE([RequestZip], '') AS RequestZip,
		[RequestDateTime],
		[ResponseDateTime],
		[ItemCount],
		[ErrorCount],
		[CreateDate],
		[LastModified],
		[AuditLogTypeID]

	FROM
			[RegistryDlaResponse]
	WHERE 
		[RegistryDlaResponseID] = COALESCE(@RegistryDlaResponseID, RegistryDlaResponseID)
	AND	[RequestFirstName] = COALESCE(@RequestFirstName, RequestFirstName)
	AND [RequestLastName] = COALESCE(@RequestLastName, RequestLastName)
	AND [RequestDOB] = COALESCE(@RequestDOB, RequestDOB)
	ORDER BY [ResponseDateTime] DESC;

	RETURN @@Error;
GO

