IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'spui_EventRegistry')
	BEGIN
		PRINT 'Dropping Procedure spui_EventRegistry'
		DROP  Procedure  spui_EventRegistry
	END

GO

PRINT 'Creating Procedure spui_EventRegistry'
GO
CREATE Procedure spui_EventRegistry
	@RegistryID int = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@EventCategorySpecifyText varchar(255) = NULL,
	@EventSubCategorySpecifyText varchar(255) = NULL
AS
/******************************************************************************
**		File: spui_EventRegistry.sql
**		Name: spui_EventRegistry
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
IF (SELECT Count(RegistryID) FROM EventRegistry WHERE RegistryID = isNull(@RegistryID, 0)) > 0
 
	BEGIN
		UPDATE EventRegistry
		
		SET
				EventCategoryID = @EventCategoryID,
				EventSubCategoryID = @EventSubCategoryID,
				EventCategorySpecifyText = @EventCategorySpecifyText,
				EventSubCategorySpecifyText = @EventSubCategorySpecifyText,
				LastModified = GetDate()

		FROM EventRegistry
		WHERE	RegistryID = @RegistryID
	END

ELSE
	BEGIN
		INSERT INTO EventRegistry
			(
				RegistryID,
				EventCategoryID,
				EventSubCategoryID,
				EventCategorySpecifyText,
				EventSubCategorySpecifyText,
				LastModified,
				CreateDate
			)
			VALUES
			(
				@RegistryID,
				@EventCategoryID,
				@EventSubCategoryID,
				@EventCategorySpecifyText,
				@EventSubCategorySpecifyText,
				GetDate(),
				GetDate()
			)

	END 


GO
