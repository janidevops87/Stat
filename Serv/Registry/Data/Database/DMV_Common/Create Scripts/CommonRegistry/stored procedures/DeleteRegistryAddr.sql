 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteRegistryAddr]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteRegistryAddr]
	PRINT 'Dropping Procedure: DeleteRegistryAddr'
END
	PRINT 'Creating Procedure: DeleteRegistryAddr'
GO

CREATE PROCEDURE [dbo].[DeleteRegistryAddr]
(
	--@RegistryAddrID int,
	@RegistryID int,
	@AddrTypeID Int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteRegistryAddr.sql
**		Name: DeleteRegistryAddr
**		Desc: 
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 03/02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/02/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	UPDATE
			[RegistryAddr]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE
	 		--[RegistryAddrID] = @RegistryAddrID
	 		[RegistryID] = @RegistryID AND
	 		[AddrTypeID] = IsNull(@AddrTypeID, AddrTypeID)

	DELETE 
	FROM   [RegistryAddr]
	WHERE  
	 		--[RegistryAddrID] = @RegistryAddrID
	 		[RegistryID] = @RegistryID AND
	 		[AddrTypeID] = IsNull(@AddrTypeID, AddrTypeID)

	RETURN @@Error
GO