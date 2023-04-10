IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQATrackingType]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQATrackingType]
			PRINT 'Dropping Procedure: InsertQATrackingType'
	END

PRINT 'Creating Procedure: InsertQATrackingType'
GO

CREATE PROCEDURE [dbo].[InsertQATrackingType]
(
	@QATrackingTypeID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQATrackingType.sql
**		Name: InsertQATrackingType
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 01/22/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/22/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingType]
	(
		[OrganizationID],
		[QATrackingTypeDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@QATrackingTypeDescription,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QATrackingTypeID = SCOPE_IDENTITY();

	RETURN @@Error
GO
