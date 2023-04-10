IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteRegistryOwnerGrantedAccess]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteRegistryOwnerGrantedAccess]
	PRINT 'Dropping Procedure: DeleteRegistryOwnerGrantedAccess'
END
	PRINT 'Creating Procedure: DeleteRegistryOwnerGrantedAccess'
GO

CREATE PROCEDURE [dbo].[DeleteRegistryOwnerGrantedAccess]
(
	@RegistryOwnerID int,
	@RegistryGrantedOwnerID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteRegistryOwnerGrantedAccess.sql
**		Name: DeleteRegistryOwnerGrantedAccess
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

	UPDATE
			[RegistryOwnerGrantedAccess]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 	
			[RegistryOwnerID] = @RegistryOwnerID AND
			[RegistryGrantedOwnerID] = IsNull(@RegistryGrantedOwnerID, RegistryGrantedOwnerId)

	DELETE 
	FROM	[RegistryOwnerGrantedAccess]
	WHERE  
			[RegistryOwnerID] = @RegistryOwnerID AND
			[RegistryGrantedOwnerID] = IsNull(@RegistryGrantedOwnerID, RegistryGrantedOwnerId)

	RETURN @@Error
GO
