
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAProcessSteps]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAProcessSteps]
	PRINT 'Dropping Procedure: GetQAProcessSteps'
END
	PRINT 'Creating Procedure: GetQAProcessSteps'
GO
 
CREATE PROCEDURE [dbo].[GetQAProcessSteps]
(
	@OrganizationID int = NULL
)
/******************************************************************************
**		File: GetQAProcessSteps.sql
**		Name: GGetQAProcessSteps
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 02/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		02/2009		jth			initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
		QAProcessStepID,
		QAProcessStepDescription
		
	
	FROM
		 QAProcessStep
	Where [OrganizationID] = IsNull(@OrganizationID, OrganizationID) and QAprocessstepactive = 1
order by QAProcessStepDescription

	RETURN @@Error

GO
 