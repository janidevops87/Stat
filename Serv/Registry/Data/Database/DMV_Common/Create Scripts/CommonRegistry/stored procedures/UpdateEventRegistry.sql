IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateEventRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateEventRegistry]
	PRINT 'Dropping Procedure: UpdateEventRegistry'
END
	PRINT 'Creating Procedure: UpdateEventRegistry'
GO

CREATE PROCEDURE [dbo].[UpdateEventRegistry]
(
	@EventRegistryID int,
	@RegistryID int = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@EventCategorySpecifyText varchar(255) = NULL,
	@EventSubCategorySpecifyText varchar(255) = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateEventRegistry.sql
**		Name: UpdateEventRegistry
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
	
	UPDATE [EventRegistry]
	SET
		[RegistryID] = IsNull(@RegistryID, RegistryID),
		[EventCategoryID] = IsNull(@EventCategoryID, EventCategoryID),
		[EventSubCategoryID] = IsNull(@EventSubCategoryID, EventSubCategoryID),
		[EventCategorySpecifyText] = IsNull(@EventCategorySpecifyText, EventCategorySpecifyText),
		[EventSubCategorySpecifyText] = IsNull(@EventSubCategorySpecifyText, EventSubCategorySpecifyText),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3 -- Modify
	WHERE 
		[EventRegistryID] = @EventRegistryID

	RETURN @@Error
GO