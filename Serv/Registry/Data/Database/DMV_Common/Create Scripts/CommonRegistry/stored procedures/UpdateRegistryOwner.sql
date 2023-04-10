IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistryOwner]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistryOwner]
	PRINT 'Dropping Procedure: UpdateRegistryOwner'
END
	PRINT 'Creating Procedure: UpdateRegistryOwner'
GO

CREATE PROCEDURE [dbo].[UpdateRegistryOwner]
(
	@RegistryOwnerID int,
	@RegistryOwnerName varchar(255) = NULL,
	@SourceCodeID int = NULL,
	@DisplaySearchPendingSignature bit = NULL,
	@DisplaySearchResultDateField bit = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateRegistryOwner.sql
**		Name: UpdateRegistryOwner
**		Desc:  National Web Registry
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 02/19/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/19/2009	ccarroll	initial
*******************************************************************************/

AS
	SET NOCOUNT ON
	
	UPDATE [RegistryOwner]
	SET
		[RegistryOwnerName] = IsNull(@RegistryOwnerName, RegistryOwnerName),
		[SourceCodeID] = IsNull(@SourceCodeID, SourceCodeID),
		[DisplaySearchPendingSignature] = IsNull(@DisplaySearchPendingSignature, DisplaySearchPendingSignature),
		[DisplaySearchResultDateField] = IsNull(@DisplaySearchResultDateField, DisplaySearchResultDateField),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[RegistryOwnerID] = @RegistryOwnerID

	RETURN @@Error
GO
