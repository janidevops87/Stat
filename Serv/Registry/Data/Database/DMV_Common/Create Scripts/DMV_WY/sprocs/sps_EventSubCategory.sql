IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_EventSubCategory')
	BEGIN
		PRINT 'Dropping Procedure sps_EventSubCategory'
		DROP  Procedure  sps_EventSubCategory
	END

GO

PRINT 'Creating Procedure sps_EventSubCategory'
GO
CREATE Procedure sps_EventSubCategory
		@EventSubCategoryID Int = NULL,
		@EventCategoryID int =NULL,
		@ViewActive	bit = NULL		/*  @ViewActive Options
								Null - View All
								0 - View Inactive Only
								1 - View Active Only
									*/
AS

/******************************************************************************
**		File: sps_EventSubCategory.sql
**		Name: sps_EventSubCategory
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
**		See above
**
**		Auth: ccarroll
**		Date: 12/04/2007
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		12/04/2007		ccarroll				Initial
*******************************************************************************/

SELECT
		EventSubCategoryID,
		EventCategoryID,
		EventSubCategoryActive AS 'Active',
		EventSubCategoryName AS 'SubCategory',
		EventSubCategorySpecifyText,
		EventSubCategorySourceCode AS 'SubSourceCode'
FROM EventSubCategory
WHERE	EventSubCategory.EventSubCategoryID = IsNull(@EventSubCategoryID, EventSubCategory.EventSubCategoryID)
	AND EventSubCategory.EventCategoryID = IsNull(@EventCategoryID, EventSubCategory.EventCategoryID)
	AND EventSubCategory.EventSubCategoryActive = IsNull(@ViewActive, EventSubCategory.EventSubCategoryActive)
ORDER BY EventSubCategoryName

GO

