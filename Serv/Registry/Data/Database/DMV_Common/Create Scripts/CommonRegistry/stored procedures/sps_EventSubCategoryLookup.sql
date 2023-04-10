IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_EventSubCategoryLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_EventSubCategoryLookup'
		DROP  Procedure  sps_EventSubCategoryLookup
	END

GO

PRINT 'Creating Procedure sps_EventSubCategoryLookup'
GO
CREATE Procedure sps_EventSubCategoryLookup
		@EventSubCategoryID Int = NULL,
		@EventCategoryID int =NULL,
		@State varchar(12),
		@ViewActive	bit = NULL		/*  @ViewActive Options
									Null - View All
									0 - View Inactive Only
									1 - View Active Only
									*/
AS

/******************************************************************************
**		File: sps_EventSubCategoryLookup.sql
**		Name: sps_EventSubCategoryLookup
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
**		Date: 03/03/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		03/03/2008		ccarroll				Initial
**	    03/27/2010		ccarroll				added NV reporting
**	    05/26/2010		ccarroll				removed table prefix in order by
**		01/27/2011		ccarroll				Added NE NORS
*******************************************************************************/
IF @State = 'CO'
/* Return Sub Categories for Colorado */

BEGIN
	SELECT	0 AS EventSubCategoryID,
			' All' AS 'EventSubCategoryName'
	UNION
	SELECT
			EventSubCategoryID,
			EventSubCategoryName AS 'EventSubCategoryName'
	FROM	DMV_CO.dbo.EventSubCategory
	WHERE	DMV_CO.dbo.EventSubCategory.EventSubCategoryID = IsNull(@EventSubCategoryID, DMV_CO.dbo.EventSubCategory.EventSubCategoryID)
		AND DMV_CO.dbo.EventSubCategory.EventCategoryID = IsNull(@EventCategoryID, DMV_CO.dbo.EventSubCategory.EventCategoryID)
		AND DMV_CO.dbo.EventSubCategory.EventSubCategoryActive = IsNull(@ViewActive, DMV_CO.dbo.EventSubCategory.EventSubCategoryActive)
	ORDER BY EventSubCategoryName
END

IF @State = 'WY'
/* Return Sub Categories for Wyoming */

BEGIN
	SELECT	0 AS EventSubCategoryID,
			' All' AS 'EventSubCategoryName'
	UNION
	SELECT
			EventSubCategoryID,
			EventSubCategoryName AS 'EventSubCategoryName'
	FROM	DMV_WY.dbo.EventSubCategory
	WHERE	DMV_WY.dbo.EventSubCategory.EventSubCategoryID = IsNull(@EventSubCategoryID, DMV_WY.dbo.EventSubCategory.EventSubCategoryID)
		AND DMV_WY.dbo.EventSubCategory.EventCategoryID = IsNull(@EventCategoryID, DMV_WY.dbo.EventSubCategory.EventCategoryID)
		AND DMV_WY.dbo.EventSubCategory.EventSubCategoryActive = IsNull(@ViewActive, DMV_WY.dbo.EventSubCategory.EventSubCategoryActive)
	ORDER BY EventSubCategoryName

END

IF @State IN ('CT', 'MA', 'ME', 'NH', 'RI', 'VT', 'NV', 'NE')
/* Return Sub Categories for for active common registry states */

BEGIN
	SELECT	0 AS EventSubCategoryID,
			' All' AS 'EventSubCategoryName'
	UNION
	SELECT
			EventSubCategoryID,
			EventSubCategoryName AS 'EventSubCategoryName'
	FROM	DMV_Common.dbo.EventSubCategory AS EventSubCategory
	WHERE	EventSubCategory.EventSubCategoryID = IsNull(@EventSubCategoryID, EventSubCategory.EventSubCategoryID)
		AND EventSubCategory.EventCategoryID = IsNull(@EventCategoryID, EventSubCategory.EventCategoryID)
		AND EventSubCategory.EventSubCategoryActive = IsNull(@ViewActive, EventSubCategory.EventSubCategoryActive)
	ORDER BY EventSubCategoryName

END
GO


