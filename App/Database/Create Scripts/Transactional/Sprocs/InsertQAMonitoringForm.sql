IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[InsertQAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
	BEGIN
			DROP PROCEDURE [dbo].[InsertQAMonitoringForm]
			PRINT 'Dropping Procedure: InsertQAMonitoringForm'
	END

PRINT 'Creating Procedure: InsertQAMonitoringForm'
GO

CREATE PROCEDURE [dbo].[InsertQAMonitoringForm]
(
	@QAMonitoringFormID int = NULL OUTPUT,
	@OrganizationID int = NULL,
	@QATrackingTypeID int = NULL,
	@QAMonitoringFormName varchar(255) = NULL,
	--@QAMonitoringFormLogo image = NULL,
	--@QAMonitoringFormStatTracLink varchar(255) = NULL,
	@QAMonitoringFormCalculateScore smallint = NULL,
	@QAMonitoringFormRequireReview smallint = NULL,
	@QAMonitoringFormActive smallint = NULL,
	@QAMonitoringFormInactiveComments varchar(1000) = NULL,
	@QAMonitoringFormScore dec = 0,
	@LastModified datetime = NULL,
	@LastStatEmployeeID int = NULL,
	@AuditLogTypeID int = NULL
)
/******************************************************************************
**		File: InsertQAMonitoringForm.sql
**		Name: InsertQAMonitoringForm
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
**      03/09       jth         added trackingtypeid
*******************************************************************************/
AS
	SET NOCOUNT ON

	INSERT INTO [QAMonitoringForm]
	(
		[OrganizationID],
		[QATrackingTypeID],
		[QAMonitoringFormName],
		--[QAMonitoringFormLogo],
		--[QAMonitoringFormStatTracLink],
		[QAMonitoringFormCalculateScore],
		[QAMonitoringFormRequireReview],
		[QAMonitoringFormActive],
		[QAMonitoringFormInactiveComments],
		QAMonitoringFormScore,
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	)
	VALUES
	(
		@OrganizationID,
		@QATrackingTypeID,
		@QAMonitoringFormName,
		--@QAMonitoringFormLogo,
		--@QAMonitoringFormStatTracLink,
		@QAMonitoringFormCalculateScore,
		@QAMonitoringFormRequireReview,
		@QAMonitoringFormActive,
		@QAMonitoringFormInactiveComments,
		@QAMonitoringFormScore,
		GetDate(),
		@LastStatEmployeeID,
		1 -- Create
	)

	SELECT @QAMonitoringFormID = SCOPE_IDENTITY();

	RETURN @@Error
GO