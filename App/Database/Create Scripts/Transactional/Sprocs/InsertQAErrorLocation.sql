IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAErrorLocation]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAErrorLocation]
			PRINT 'Dropping Procedure: InsertQAErrorLocation'
	END

PRINT 'Creating Procedure: InsertQAErrorLocation'
GO

CREATE PROCEDURE [dbo].[InsertQAErrorLocation]
(
	@QAErrorLocationID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QAErrorLocationDescription varchar(255) = NULL,
	@QAErrorLocationActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAErrorLocation.sql
**		Name: InsertQAErrorLocation
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

	INSERT INTO [QAErrorLocation]
	(
		[OrganizationID],
		[QAErrorLocationDescription],
		[QAErrorLocationActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@QAErrorLocationDescription,
		@QAErrorLocationActive,
		GetDate(),
		@LastStatEmployeeID,
		1 --Create
	)

	SELECT @QAErrorLocationID = SCOPE_IDENTITY();

	RETURN @@Error
GO
