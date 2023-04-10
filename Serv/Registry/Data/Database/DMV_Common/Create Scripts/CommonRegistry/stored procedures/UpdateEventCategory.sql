IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[UpdateEventCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[UpdateEventCategory]
	PRINT 'Dropping Procedure: UpdateEventCategory'
END
	PRINT 'Creating Procedure: UpdateEventCategory'
GO

CREATE PROCEDURE [dbo].[UpdateEventCategory]
(
	@EventCategoryID int,
	@RegistryOwnerID int,
	@EventCategoryName varchar(255) = NULL,
	@EventCategoryActive bit,
	@EventCategorySpecifyText bit,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: UpdateEventCategory.sql
**		Name: UpdateEventCategory
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
	
	UPDATE [EventCategory]
	SET
		[RegistryOwnerID] = IsNull(@RegistryOwnerID, RegistryOwnerID),
		[EventCategoryName] = IsNull(@EventCategoryName, EventCategoryName),
		[EventCategoryActive] = IsNull(@EventCategoryActive, EventCategoryActive),
		[EventCategorySpecifyText] = IsNull(@EventCategorySpecifyText, EventCategorySpecifyText),
		[LastModified] = GetDate(),
		[LastStatEmployeeID] = IsNull(@LastStatEmployeeID, LastStatEmployeeID),
		[AuditLogTypeID] = 3
	WHERE 
		[EventCategoryID] = @EventCategoryID

	RETURN @@Error
GO
