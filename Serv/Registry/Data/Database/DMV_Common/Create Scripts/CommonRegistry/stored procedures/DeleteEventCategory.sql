IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteEventCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteEventCategory]
	PRINT 'Dropping Procedure: DeleteEventCategory'
END
	PRINT 'Creating Procedure: DeleteEventCategory'
GO

CREATE PROCEDURE [dbo].[DeleteEventCategory]
(
	@EventCategoryID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteEventCategory.sql
**		Name: DeleteEventCategory
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
			[EventCategory]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[EventCategoryID] = @EventCategoryID

	DELETE 
	FROM   [EventCategory]
	WHERE  
		[EventCategoryID] = @EventCategoryID

	RETURN @@Error
GO
