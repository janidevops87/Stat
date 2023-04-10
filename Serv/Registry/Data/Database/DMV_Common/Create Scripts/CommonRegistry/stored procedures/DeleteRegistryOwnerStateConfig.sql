IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteRegistryOwnerStateConfig]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteRegistryOwnerStateConfig]
	PRINT 'Dropping Procedure: DeleteRegistryOwnerStateConfig'
END
	PRINT 'Creating Procedure: DeleteRegistryOwnerStateConfig'
GO

CREATE PROCEDURE [dbo].[DeleteRegistryOwnerStateConfig]
(
	@RegistryOwnerStateConfigID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteRegistryOwnerStateConfig.sql
**		Name: DeleteRegistryOwnerStateConfig
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
			[RegistryOwnerStateConfig]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[RegistryOwnerStateConfigID] = @RegistryOwnerStateConfigID

	DELETE 
	FROM   [RegistryOwnerStateConfig]
	WHERE  
		[RegistryOwnerStateConfigID] = @RegistryOwnerStateConfigID

	RETURN @@Error
GO
