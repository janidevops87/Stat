 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[spi_Audit_QAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[spi_Audit_QAProcessStep]
			PRINT 'Dropping Procedure: spi_Audit_QAProcessStep'
	END

PRINT 'Creating Procedure: spi_Audit_QAProcessStep'
GO

CREATE PROCEDURE [dbo].[spi_Audit_QAProcessStep]
(
	@QAProcessStepID int = NULL,
	@OrganizationID int = NULL,
	@QAProcessStepDescription varchar(255) = NULL,
	@QAProcessStepActive smallint = NULL,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************* ***********************************
**		File: spi_Audit_QAProcessStep.sql 
**		Name: spi_Audit_QAProcessStep
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:   
**              
**
**		Auth: bret
**		Date: 7/7/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		7/7/2009	bret		initial
**		04/25/2012  ccarroll	Added note for inclusion in release CCRST143
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAProcessStep]
	(
		[QAProcessStepID],
		[OrganizationID],
		[QAProcessStepDescription],
		[QAProcessStepActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@QAProcessStepID,
		@OrganizationID,
		@QAProcessStepDescription,
		@QAProcessStepActive,
		@LastModified,
		@LastStatEmployeeID,
		@AuditLogTypeID
	)
	