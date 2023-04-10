IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAProcessStep]
			PRINT 'Dropping Procedure: InsertQAProcessStep'
	END

PRINT 'Creating Procedure: InsertQAProcessStep'
GO

CREATE PROCEDURE [dbo].[InsertQAProcessStep]
(
	@QAProcessStepID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QAProcessStepDescription varchar(255) = NULL,
	@QAProcessStepActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAProcessStep.sql
**		Name: InsertQAProcessStep
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

	INSERT INTO [QAProcessStep]
	(
		[OrganizationID],
		[QAProcessStepDescription],
		[QAProcessStepActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@QAProcessStepDescription,
		@QAProcessStepActive,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QAProcessStepID = SCOPE_IDENTITY();

	RETURN @@Error
GO