IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAErrorStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAErrorStatus]
			PRINT 'Dropping Procedure: InsertQAErrorStatus'
	END

PRINT 'Creating Procedure: InsertQAErrorStatus'
GO

CREATE PROCEDURE [dbo].[InsertQAErrorStatus]
(
	@QAErrorStatusID int = NULL OUTPUT,
	@QAErrorStatusDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAErrorStatus.sql
**		Name: InsertQAErrorStatus
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

	INSERT INTO [QAErrorStatus]
	(
		[QAErrorStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorStatusDescription,
		GetDate(),
		@LastStatEmployeeID,
		1 --Create
	)

	SELECT @QAErrorStatusID = SCOPE_IDENTITY();

	RETURN @@Error
GO
