 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQATrackingStatus]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQATrackingStatus]
			PRINT 'Dropping Procedure: InsertQATrackingStatus'
	END

PRINT 'Creating Procedure: InsertQATrackingStatus'
GO

CREATE PROCEDURE [dbo].[InsertQATrackingStatus]
(
	@QATrackingStatusID int = NULL OUTPUT,
	@QATrackingStatusDescription varchar(255) = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQATrackingStatus.sql
**		Name: InsertQATrackingStatus
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: ccarroll
**		Date: 01/30/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/30/2009	ccarroll	initial
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QATrackingStatus]
	(
		[QATrackingStatusDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QATrackingStatusDescription,
		GetDate(),
		@LastStatEmployeeID,
		1 --Create
	)

	SELECT @QATrackingStatusID = SCOPE_IDENTITY();

	RETURN @@Error
GO
