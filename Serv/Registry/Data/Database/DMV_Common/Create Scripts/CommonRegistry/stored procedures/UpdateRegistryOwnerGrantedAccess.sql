IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateRegistryOwnerGrantedAccess]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateRegistryOwnerGrantedAccess]
	PRINT 'Dropping Procedure: UpdateRegistryOwnerGrantedAccess'
END
	PRINT 'Creating Procedure: UpdateRegistryOwnerGrantedAccess'
GO

CREATE PROCEDURE [dbo].[UpdateRegistryOwnerGrantedAccess]
(
	@RegistryOwnerID int,
	@RegistryGrantedOwnerID int,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateRegistryOwnerGrantedAccess.sql
**		Name: UpdateRegistryOwnerGrantedAccess
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
	
	UPDATE [RegistryOwnerGrantedAccess]
	SET
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID),
		[RegistryGrantedOwnerID] = IsNull(@RegistryGrantedOwnerID, RegistryGrantedOwnerID),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[RegistryOwnerID] = @RegistryOwnerID

	RETURN @@Error
GO
