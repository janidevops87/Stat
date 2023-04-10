IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_EventCategory')
	BEGIN
		PRINT 'Dropping Procedure sps_EventCategory'
		DROP  Procedure  sps_EventCategory
	END

GO

PRINT 'Creating Procedure sps_EventCategory'
GO
CREATE Procedure sps_EventCategory
		@EventCategoryID int = NULL,
		@ViewActive	bit	= NULL		/*  @ViewActive Options
								Null - View All
								0 - View Inactive Only
								1 - View Active Only
							 */
		
AS

/******************************************************************************
**		File: sps_EventCategory.sql
**		Name: sps_EventCategory
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll						12/04/2007
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		12/04/2007		ccarroll				Initial
**		08/19/2010		ccarroll				Added sorting to the Event Category
*******************************************************************************/

SELECT
	EventCategoryID,
	EventCategoryActive AS 'Active',
	EventCategoryName AS 'Category',
	EventCategorySpecifyText
FROM EventCategory
WHERE	EventCategory.EventCategoryID = IsNull(@EventCategoryID, EventCategory.EventCategoryID)
	AND EventCategory.EventCategoryActive = IsNull(@ViewActive, EventCategory.EventCategoryActive)
	ORDER BY EventCategoryName
GO
