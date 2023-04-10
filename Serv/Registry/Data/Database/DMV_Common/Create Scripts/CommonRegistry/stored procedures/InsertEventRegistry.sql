IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertEventRegistry]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertEventRegistry]
			PRINT 'Dropping Procedure: InsertEventRegistry'
	END

PRINT 'Creating Procedure: InsertEventRegistry'
GO

CREATE PROCEDURE [dbo].[InsertEventRegistry]
(
	@EventRegistryID int = NULL OUTPUT,
	@RegistryID int = NULL,
	@EventCategoryID int = NULL,
	@EventSubCategoryID int = NULL,
	@EventCategorySpecifyText varchar(255) = NULL,
	@EventSubCategorySpecifyText varchar(255) = NULL,
	@LastStatEmployeeID int = NULL
)
/******************************************************************************
**		File: InsertEventRegistry.sql
**		Name: InsertEventRegistry
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
	
	
IF @EventCategoryID = 0
BEGIN
SET @EventCategoryID = Null
END

IF @EventSubCategoryID = 0
BEGIN
SET @EventSubCategoryID = Null
END


	INSERT INTO [EventRegistry]
	(
		[RegistryID],
		[EventCategoryID],
		[EventSubCategoryID],
		[EventCategorySpecifyText],
		[EventSubCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RegistryID,
		@EventCategoryID,
		@EventSubCategoryID,
		@EventCategorySpecifyText,
		@EventSubCategorySpecifyText,
		GetDate(),
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @EventRegistryID = SCOPE_IDENTITY();

	RETURN @@Error
GO
