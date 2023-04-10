/******************************************************************************
**		File: Migrate_CODA_EventCategory_to_DMV_Common.sql
**		Name: Migrate_CODA_EventCategory_to_DMV_Common
**		Desc: This cursor updates EventCategory 
**              
**		Return values: 
**		
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:			Description:
**		--------	--------		-------------------------------------
**		03/13/2012	ccarroll		Initial
*******************************************************************************/

SET NOCOUNT ON

DECLARE @RegistryOwnerName nvarchar(100),
		@RegistryOwnerId int,
		@EventCategoryId int,
		@EventCategoryName nvarchar(255)
		


SET @RegistryOwnerName = 'CODA'
SET @RegistryOwnerId = (SELECT RegistryOwnerId FROM RegistryOwner WHERE RegistryOwnerName = @RegistryOwnerName) 


/* Define scope of cursor */
DECLARE getRegistryOwnerEventCategory_cursor CURSOR FOR
		SELECT EventCategoryId 
		FROM DMV_CO.dbo.EventCategory
OPEN getRegistryOwnerEventCategory_cursor

FETCH NEXT
	FROM getRegistryOwnerEventCategory_cursor INTO @EventCategoryId

WHILE @@FETCH_STATUS = 0
BEGIN

SET @EventCategoryName = (SELECT EventCategoryName
							FROM DMV_CO.dbo.EventCategory
							WHERE EventCategoryID = @EventCategoryId)

IF (SELECT Count(EventCategoryName) 
	FROM EventCategory 
	WHERE RegistryOwnerID = @RegistryOwnerId
	AND PATINDEX(@EventCategoryName, EventCategoryName) > 0
	AND IsNull(EventCategoryActive, 0) = 1) = 0
BEGIN
	/* Active record does not exist */
	/* Insert existing active Event Category */
	INSERT INTO EventCategory (
		RegistryOwnerId,
		EventCategoryName,
		EventCategoryActive,
		EventCategorySpecifyText,
		CreateDate,
		LastModified,
		LastStatEmployeeID, 
		AuditLogTypeID
	)
	SELECT TOP 1
		@RegistryOwnerId AS RegistryOwnerId,
		EventCategoryName,
		EventCategoryActive,
		EventCategorySpecifyText,
		GetDate() AS CreateDate,
		GetDate() AS LastModified,
		1100 AS LastStatEmployeeID, 
		1 AS AuditLogTypeID
	FROM DMV_CO.dbo.EventCategory
	WHERE EventCategoryName LIKE @EventCategoryName
	AND IsNull(EventCategoryActive, 0) = 1
END  

/* Add Update here*/
--ELSE
--BEGIN
--	UPDATE EventCategory 
--	SET
--		EventCategoryName = EventCategoryName,
--		EventCategoryActive,
--		EventCategorySpecifyText,
--		CreateDate,
--		LastModified,
--		LastStatEmployeeID, 
--		AuditLogTypeID
--	)
--END
/* Create identy xref table here 

SELECT INTO EventCateory_DMV_CO
SELECT EventCategory.EventCategoryID AS CommonEventCategoryID,
DMV.EventCategoryID AS DMVEventCategoryID
FROM EventCategory 
JOIN DMV_CO.dbo.EventCategory DMV ON DMV.EventCategoryName = EventCategory.EventCategoryName
WHERE RegistryOwnerID = @RegistryOwnerId

*/
FETCH NEXT
	FROM getRegistryOwnerEventCategory_cursor INTO @EventCategoryID
END
CLOSE getRegistryOwnerEventCategory_cursor
DEALLOCATE getRegistryOwnerEventCategory_cursor

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

