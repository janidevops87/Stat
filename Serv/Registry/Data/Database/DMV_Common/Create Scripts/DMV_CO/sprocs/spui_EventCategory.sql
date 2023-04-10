IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spui_EventCategory')
	BEGIN
		PRINT 'Dropping Procedure spui_EventCategory'
		DROP  Procedure  spui_EventCategory
	END

GO

PRINT 'Creating Procedure spui_EventCategory'
GO
CREATE Procedure spui_EventCategory
	@EventCateGoryID int = NULL,
	@EventCategoryName varchar(255) = NULL,
	@EventCategoryActive bit = NULL,
	@EventCategorySpecifyText bit = NULL,
	@WebUserID int = NULL
AS

/******************************************************************************
**		File: spui_EventCategory.sql
**		Name: spui_EventCategory
**		Desc: 
**
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**		Auth: ccarroll	
**		Date: 12/04/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		12/04/2007		ccarroll				Initial
*******************************************************************************/

/* Determine if this is an Insert or Update */
IF IsNull(@EventCategoryID, 0)  = 0 
	BEGIN
		INSERT INTO EventCategory
			(
				EventCategoryName,
				EventCategoryActive,
				EventCategorySpecifyText,
				WebUserID,
				LastModified,
				CreateDate
			)
			VALUES
			(
				@EventCategoryName,
				@EventCategoryActive,
				@EventCategorySpecifyText,
				@WebUserID,
				GetDate(),
				GetDate()
			)
	END

ELSE

	BEGIN
		UPDATE EventCategory
		
		SET
				EventCategoryName = @EventCategoryName,
				EventCategoryActive = @EventCategoryActive,
				EventCategorySpecifyText = @EventCategorySpecifyText,
				WebUserID = @WebUserID,
				LastModified = GetDate()

		FROM EventCategory
		WHERE	EventCategoryID = @EventCategoryID
	END



GO

