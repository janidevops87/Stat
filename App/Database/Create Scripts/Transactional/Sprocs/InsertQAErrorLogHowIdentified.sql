IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAErrorLogHowIdentified]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAErrorLogHowIdentified]
			PRINT 'Dropping Procedure: InsertQAErrorLogHowIdentified'
	END

PRINT 'Creating Procedure: InsertQAErrorLogHowIdentified'
GO

CREATE PROCEDURE [dbo].[InsertQAErrorLogHowIdentified]
(
	@QAErrorLogHowIdentifiedID int = NULL OUTPUT,
	@QAErrorLogHowIdentifiedDescription int = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAErrorLogHowIdentified.sql
**		Name: InsertQAErrorLogHowIdentified
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

	INSERT INTO [QAErrorLogHowIdentified]
	(
		[QAErrorLogHowIdentifiedDescription],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAErrorLogHowIdentifiedDescription,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QAErrorLogHowIdentifiedID = SCOPE_IDENTITY();

	RETURN @@Error
GO
