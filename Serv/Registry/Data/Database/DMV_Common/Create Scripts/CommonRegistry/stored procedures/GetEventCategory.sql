IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetEventCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetEventCategory]
	PRINT 'Dropping Procedure: GetEventCategory'
END
	PRINT 'Creating Procedure: GetEventCategory'
GO

CREATE PROCEDURE [dbo].[GetEventCategory]
(
	@EventCategoryID int = NULL,
	@RegistryOwnerID int = NULL,
	@EventCategoryActive int = NULL

)
/******************************************************************************
**		File: GetEventCategory.sql
**		Name: GetEventCategory
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
IF IsNull(@EventCategoryID, 0) = 0
BEGIN
	SET @EventCategoryID = Null
END

IF IsNull(@EventCategoryActive, 0) = 0
BEGIN
	SET @EventCategoryActive = Null
END


	SELECT
		[EventCategoryID],
		[RegistryOwnerID],
		[EventCategoryName],
		[EventCategoryActive],
		[EventCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[EventCategory]
	WHERE 
		[EventCategoryID] = IsNull(@EventCategoryID, EventCategoryID) AND
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID) AND
		[EventCategoryActive] = IsNull(@EventCategoryActive, EventCategoryActive)
	
	ORDER BY [EventCategoryName]


	RETURN @@Error
GO
