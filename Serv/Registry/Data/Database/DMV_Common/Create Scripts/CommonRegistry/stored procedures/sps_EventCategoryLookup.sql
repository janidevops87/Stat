IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_EventCategoryLookup')
	BEGIN
		PRINT 'Dropping Procedure sps_EventCategoryLookup'
		DROP  Procedure  sps_EventCategoryLookup
	END

GO

PRINT 'Creating Procedure sps_EventCategoryLookup'
GO
CREATE Procedure sps_EventCategoryLookup
		@EventCategoryID int = NULL,
		@State varchar(12),
		@ViewActive	bit	= NULL 		/*  @ViewActive Options
										Null - View All
										0 - View Inactive Only
										1 - View Active Only
									*/
		
AS

/******************************************************************************
**		File: sps_EventCategoryLookup.sql
**		Name: sps_EventCategoryLookup
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
**		Auth: ccarroll						03/03/2007
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**     03/03/2007		ccarroll				Initial
**	   05/03/2010		ccarroll				added NV reporting
**	   05/26/2010		ccarroll				removed table prefix in order by
**	   01/27/2011		ccarroll				Added Lookup for NORS
*******************************************************************************/
DECLARE @RegistryOwnerID AS Int

IF @State = 'CO'
/* Return Categories for Colorado */

BEGIN
	SELECT
			0 AS EventCategoryID,
			' All' AS EventCategoryName

	UNION

	SELECT
			EventCategoryID,
			EventCategoryName
	FROM	DMV_CO.dbo.EventCategory
	WHERE	DMV_CO.dbo.EventCategory.EventCategoryID = IsNull(@EventCategoryID, DMV_CO.dbo.EventCategory.EventCategoryID)
		AND DMV_CO.dbo.EventCategory.EventCategoryActive = IsNull(@ViewActive, DMV_CO.dbo.EventCategory.EventCategoryActive)
	ORDER BY EventCategoryName
END

IF @State = 'WY'
/* Return Categories for Wyoming */
BEGIN
	SELECT
			0 AS EventCategoryID,
			' All' AS EventCategoryName

	UNION

	SELECT
			EventCategoryID,
			EventCategoryName
	FROM	DMV_WY.dbo.EventCategory
	WHERE	DMV_WY.dbo.EventCategory.EventCategoryID = IsNull(@EventCategoryID, DMV_WY.dbo.EventCategory.EventCategoryID)
		AND DMV_WY.dbo.EventCategory.EventCategoryActive = IsNull(@ViewActive, DMV_WY.dbo.EventCategory.EventCategoryActive)
	ORDER BY EventCategoryName
END

IF @State IN ('CT', 'MA', 'ME', 'NH', 'RI', 'VT')
/* Return Categories for NEOB */

BEGIN
	SELECT
			0 AS EventCategoryID,
			' All' AS EventCategoryName

	UNION

	SELECT
			EventCategoryID,
			EventCategoryName
	FROM	DMV_Common.dbo.EventCategory AS EventCategory
	WHERE	EventCategory.EventCategoryID = IsNull(@EventCategoryID, EventCategory.EventCategoryID)
		AND EventCategory.EventCategoryActive = IsNull(@ViewActive, EventCategory.EventCategoryActive)
		AND EventCategory.RegistryOwnerID = 1 /* NEOB */
	ORDER BY EventCategoryName
END

IF @State = 'NE'
/* Return Categories for NORS */
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM DMV_Common.dbo.RegistryOwner WHERE RegistryOwnerName = 'NORS') 

	SELECT
			0 AS EventCategoryID,
			' All' AS EventCategoryName

	UNION

	SELECT
			EventCategoryID,
			EventCategoryName
	FROM	DMV_Common.dbo.EventCategory AS EventCategory
	WHERE	EventCategory.EventCategoryID = IsNull(@EventCategoryID, EventCategory.EventCategoryID)
		AND EventCategory.EventCategoryActive = IsNull(@ViewActive, EventCategory.EventCategoryActive)
		AND EventCategory.RegistryOwnerID = @RegistryOwnerID /* Nevada */
	ORDER BY EventCategoryName
END


IF @State = 'NV'
/* Return Categories for NDN */
BEGIN
SET @RegistryOwnerID = (SELECT RegistryOwnerID FROM DMV_Common.dbo.RegistryOwner WHERE RegistryOwnerName = 'NDN') 

	SELECT
			0 AS EventCategoryID,
			' All' AS EventCategoryName

	UNION

	SELECT
			EventCategoryID,
			EventCategoryName
	FROM	DMV_Common.dbo.EventCategory AS EventCategory
	WHERE	EventCategory.EventCategoryID = IsNull(@EventCategoryID, EventCategory.EventCategoryID)
		AND EventCategory.EventCategoryActive = IsNull(@ViewActive, EventCategory.EventCategoryActive)
		AND EventCategory.RegistryOwnerID = @RegistryOwnerID /* Nevada */
	ORDER BY EventCategoryName
END


GO