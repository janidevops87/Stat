IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAProcessStep]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAProcessStep]
	PRINT 'Dropping Procedure: GetQAProcessStep'
END
	PRINT 'Creating Procedure: GetQAProcessStep'
GO

CREATE PROCEDURE [dbo].[GetQAProcessStep]
(
	@OrganizationID int = NULL,
	@QAProcessStepActive smallint = NULL

)
/******************************************************************************
**		File: GetQAProcessStep.sql
**		Name: GetQAProcessStep
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: ccarroll
**		Date: 01/23/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		01/23/2009	ccarroll	initial
**      03/09       jth         active logic was backwards   
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	IF @QAProcessStepActive =0
		BEGIN
			/* Display All ProcessSteps */
			SET @QAProcessStepActive =1
		END
	ELSE 
		BEGIN
			/* Only display active ProcessSteps */	 
			SET @QAProcessStepActive =null
		END

	SELECT
		[QAProcessStepID],
		[OrganizationID],
		[QAProcessStepDescription],
		[QAProcessStepActive],
		[LastModified],
		[LastStatEmployeeID],
		[AuditLogTypeID]
	
	FROM
			[QAProcessStep]
	WHERE 
		[OrganizationID] = IsNull(@OrganizationID, OrganizationID) AND
		[QAProcessStepActive] = IsNull(@QAProcessStepActive, QAProcessStepActive)
		order by QAProcessStepDescription


	RETURN @@Error
GO


