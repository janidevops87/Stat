IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[DeleteEventSubCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[DeleteEventSubCategory]
	PRINT 'Dropping Procedure: DeleteEventSubCategory'
END
	PRINT 'Creating Procedure: DeleteEventSubCategory'
GO

CREATE PROCEDURE [dbo].[DeleteEventSubCategory]
(
	@EventSubCategoryID int,
	@LastStatEmployeeID int
)
/******************************************************************************
**		File: DeleteEventSubCategory.sql
**		Name: DeleteEventSubCategory
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
			[EventSubCategory]
	SET
			LastModified = GetDate(),
			LastStatEmployeeID = @LastStatEmployeeID,
			AuditLogTypeID = 4 -- @AuditLogTypeID 4 = Delete 
	WHERE 			[EventSubCategoryID] = @EventSubCategoryID

	DELETE 
	FROM   [EventSubCategory]
	WHERE  
		[EventSubCategoryID] = @EventSubCategoryID

	RETURN @@Error
GO
