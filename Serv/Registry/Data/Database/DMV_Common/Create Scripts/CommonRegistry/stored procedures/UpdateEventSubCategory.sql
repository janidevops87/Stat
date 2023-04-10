IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateEventSubCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateEventSubCategory]
	PRINT 'Dropping Procedure: UpdateEventSubCategory'
END
	PRINT 'Creating Procedure: UpdateEventSubCategory'
GO

CREATE PROCEDURE [dbo].[UpdateEventSubCategory]
(
	@EventSubCategoryID int,
	@EventCategoryID int = NULL,
	@EventSubCategoryName varchar(255) = NULL,
	@EventSubCategorySourceCode varchar(255) = NULL,
	@EventSubCategoryActive bit,
	@EventSubCategorySpecifyText bit,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateEventSubCategory.sql
**		Name: UpdateEventSubCategory
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
	
	UPDATE [EventSubCategory]
	SET
		[EventCategoryID] = IsNull(@EventCategoryID, EventCategoryID),
		[EventSubCategoryName] = IsNull(@EventSubCategoryName, EventSubCategoryName),
		[EventSubCategorySourceCode] = IsNull(@EventSubCategorySourceCode, EventSubCategorySourceCode),
		[EventSubCategoryActive] = IsNull(@EventSubCategoryActive, EventSubCategoryActive),
		[EventSubCategorySpecifyText] = IsNull(@EventSubCategorySpecifyText, EventSubCategorySpecifyText),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 --Modify
	WHERE 
		[EventSubCategoryID] = @EventSubCategoryID

	RETURN @@Error
GO
