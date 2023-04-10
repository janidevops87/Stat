IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertEventCategory]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertEventCategory]
			PRINT 'Dropping Procedure: InsertEventCategory'
	END

PRINT 'Creating Procedure: InsertEventCategory'
GO

CREATE PROCEDURE [dbo].[InsertEventCategory]
(
	@EventCategoryID int = NULL OUTPUT,
	@RegistryOwnerID int,
	@EventCategoryName varchar(255) = NULL,
	@EventCategoryActive bit,
	@EventCategorySpecifyText bit,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertEventCategory.sql
**		Name: InsertEventCategory
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

	INSERT INTO [EventCategory]
	(
		[RegistryOwnerID],
		[EventCategoryName],
		[EventCategoryActive],
		[EventCategorySpecifyText],
		[CreateDate],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@RegistryOwnerID,
		@EventCategoryName,
		@EventCategoryActive,
		@EventCategorySpecifyText,
		GetDate(),
		GetDate(),
		@LastStatEmployeeID,
		@AuditLogTypeID
	)

	SELECT EventCategoryID,
		@RegistryOwnerID,
		@EventCategoryName,
		@EventCategoryActive,
		@EventCategorySpecifyText,
		@LastStatEmployeeID,
		@AuditLogTypeID

	FROM   EventCategory
	WHERE  EventCategoryID = SCOPE_IDENTITY();

	RETURN @@Error
GO