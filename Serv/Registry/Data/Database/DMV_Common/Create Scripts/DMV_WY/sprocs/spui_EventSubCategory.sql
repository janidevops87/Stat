IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spui_EventSubCategory')
	BEGIN
		PRINT 'Dropping Procedure spui_EventSubCategory'
		DROP  Procedure  spui_EventSubCategory
	END

GO

PRINT 'Creating Procedure spui_EventSubCategory'
GO
CREATE Procedure spui_EventSubCategory
	@EventSubCategoryID int = NULL,
	@EventCateGoryID int = NULL,
	@EventSubCategoryName varchar(255) = NULL,
	@EventSubCategorySourceCode varchar(255) = NULL,
	@EventSubCategoryActive bit = NULL,
	@EventSubCategorySpecifyText bit = NULL,
	@WebUserID int = NULL
AS

/******************************************************************************
**		File: spui_EventSubCategory.sql
**		Name: spui_EventSubCategory
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See Above
**
**		Auth: ccarroll
**		Date: 12/04/2007 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		12/04/2007		ccarroll				initial
*******************************************************************************/

/* Determine if this is an Insert or Update */
IF isNull(@EventSubCategoryID, 0) = 0 
	BEGIN
		INSERT INTO EventSubCategory
			(
				EventCategoryID,
				EventSubCategoryName,
				EventSubCategorySourceCode,
				EventSubCategoryActive,
				EventSubCategorySpecifyText,
				WebUserID,
				LastModified,
				CreateDate
			)
			VALUES
			(
				@EventCateGoryID,
				@EventSubCategoryName,
				@EventSubCategorySourceCode,
				@EventSubCategoryActive,
				@EventSubCategorySpecifyText,
				@WebUserID,
				GetDate(),
				GetDate()
			)
	END

ELSE

	BEGIN
		UPDATE EventSubCategory
		
		SET
				EventCategoryID = @EventCategoryID,
				EventSubCategoryName = @EventSubCategoryName,
				EventSubCategorySourceCode = @EventSubCategorySourceCode,
				EventSubCategoryActive = @EventSubCategoryActive,
				EventSubCategorySpecifyText = @EventSubCategorySpecifyText,
				WebUserID = @WebUserID,
				LastModified = GetDate()

		FROM EventSubCategory
		WHERE	EventSubCategoryID = @EventSubCategoryID
	END



GO

