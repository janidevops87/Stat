IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteEventRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteEventRegistry]
	PRINT 'Dropping Procedure: DeleteEventRegistry'
END
	PRINT 'Creating Procedure: DeleteEventRegistry'
GO

CREATE PROCEDURE [dbo].[DeleteEventRegistry]
(
	@EventRegistryID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteEventRegistry.sql
**		Name: DeleteEventRegistry
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
			[EventRegistry]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[EventRegistryID] = @EventRegistryID

	DELETE 
	FROM   [EventRegistry]
	WHERE  
		[EventRegistryID] = @EventRegistryID

	RETURN @@Error
GO