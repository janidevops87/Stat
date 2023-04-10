IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteRegistryOwner]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteRegistryOwner]
	PRINT 'Dropping Procedure: DeleteRegistryOwner'
END
	PRINT 'Creating Procedure: DeleteRegistryOwner'
GO

CREATE PROCEDURE [dbo].[DeleteRegistryOwner]
(
	@RegistryOwnerID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteRegistryOwner.sql
**		Name: DeleteRegistryOwner
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
			[RegistryOwner]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[RegistryOwnerID] = @RegistryOwnerID

	DELETE 
	FROM   [RegistryOwner]
	WHERE  
		[RegistryOwnerID] = @RegistryOwnerID

	RETURN @@Error
GO
