IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetEventSubCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetEventSubCategory]
	PRINT 'Dropping Procedure: GetEventSubCategory'
END
	PRINT 'Creating Procedure: GetEventSubCategory'
GO

CREATE PROCEDURE [dbo].[GetEventSubCategory]
(
	@EventSubCategoryID int = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryActive int = NULL
)
/******************************************************************************
**		File: GetEventSubCategory.sql
**		Name: GetEventSubCategory
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

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

/* nullify default values */
IF IsNull(@EventSubCategoryID, 0) = 0
BEGIN
	SET @EventSubCategoryID = Null
END

IF IsNull(@EventCategoryID, 0) = 0
BEGIN
	SET @EventCategoryID = Null
END


IF IsNull(@EventSubCategoryActive, 0) = 0
BEGIN
	SET @EventSubCategoryActive = Null
END


	SELECT
		[EventSubCategoryID],
		[EventCategoryID],
		[EventSubCategoryName],
		[EventSubCategorySourceCode],
		[EventSubCategoryActive],
		[EventSubCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[EventSubCategory]
	WHERE 
		[EventSubCategoryID] = IsNull(@EventSubCategoryID, EventSubCategoryID) AND
		[EventCategoryID] = IsNull(@EventCategoryID, EventCategoryID) AND
		[EventSubCategoryActive] = IsNull(@EventSubCategoryActive, EventSubCategoryActive)

	ORDER BY [EventSubCategoryName] 


	RETURN @@Error
GO

