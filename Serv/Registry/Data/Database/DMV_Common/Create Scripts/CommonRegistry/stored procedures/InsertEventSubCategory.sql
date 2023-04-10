IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertEventSubCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertEventSubCategory]
			PRINT 'Dropping Procedure: InsertEventSubCategory'
	END

PRINT 'Creating Procedure: InsertEventSubCategory'
GO

CREATE PROCEDURE [dbo].[InsertEventSubCategory]
(
	@EventSubCategoryID int = NULL OUTPUT,
	@EventCategoryID int = NULL,
	@EventSubCategoryName varchar(255) = NULL,
	@EventSubCategorySourceCode varchar(255) = NULL,
	@EventSubCategoryActive bit,
	@EventSubCategorySpecifyText bit,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: InsertEventSubCategory.sql
**		Name: InsertEventSubCategory
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

	INSERT INTO [EventSubCategory]
	(
		[EventCategoryID],
		[EventSubCategoryName],
		[EventSubCategorySourceCode],
		[EventSubCategoryActive],
		[EventSubCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@EventCategoryID,
		@EventSubCategoryName,
		@EventSubCategorySourceCode,
		@EventSubCategoryActive,
		@EventSubCategorySpecifyText,
		GetDate(), --@CreateDate
		GetDate(), --@LastModified
		@LastStatEmployeeID,
		1 --Create: @AuditLogTypeID
	)

	SELECT EventSubCategoryID,
		@EventCategoryID,
		@EventSubCategoryName,
		@EventSubCategorySourceCode,
		@EventSubCategoryActive,
		@EventSubCategorySpecifyText,
		@LastStatEmployeeID
	FROM EventSubCategory

	WHERE EventSubCategoryID = SCOPE_IDENTITY();
	RETURN @@Error
GO