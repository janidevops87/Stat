IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAMonitoringForms]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAMonitoringForms]
	PRINT 'Dropping Procedure: GetQAMonitoringForms'
END
	PRINT 'Creating Procedure: GetQAMonitoringForms'
GO

CREATE PROCEDURE [dbo].[GetQAMonitoringForms]
(
	@QAMonitoringFormActive int = NULL,
	@OrganizationID int = NULL

)
/******************************************************************************
**		File: GetQAMonitoringForms.sql
**		Name: GetQAMonitoringForms
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/2009		jth			initial
*******************************************************************************/
AS
IF @QAMonitoringFormActive =0
		BEGIN
			/* Display All ProcessSteps */
			SET @QAMonitoringFormActive =1
		END
	ELSE 
		BEGIN
			/* Only display active ProcessSteps */	 
			SET @QAMonitoringFormActive =null
		END
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		[QAMonitoringFormID],
		[OrganizationID],
		[QAMonitoringFormName],
		--[QAMonitoringFormLogo],
		--[QAMonitoringFormStatTracLink],
		[QAMonitoringFormCalculateScore],
		[QAMonitoringFormRequireReview],
		[QAMonitoringFormActive],
		[QAMonitoringFormInactiveComments],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QAMonitoringForm]
	WHERE 
		[QAMonitoringFormActive] = IsNull(@QAMonitoringFormActive, QAMonitoringFormActive) AND
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID)


	RETURN @@Error
GO


 