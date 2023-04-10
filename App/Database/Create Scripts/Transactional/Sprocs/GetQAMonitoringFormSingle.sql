IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAMonitoringFormSingle]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAMonitoringFormSingle]
	PRINT 'Dropping Procedure: GetQAMonitoringFormSingle'
END
	PRINT 'Creating Procedure: GetQAMonitoringFormSingle'
GO

CREATE PROCEDURE [dbo].[GetQAMonitoringFormSingle]
(
	@QAMonitoringFormID int = NULL
	

)
/******************************************************************************
**		File: GetQAMonitoringFormSingle.sql
**		Name: GetQAMonitoringFormSingle
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
**		03/2009		jth			initial
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT distinct
		QAMonitoringForm.QAMonitoringFormID,
		[QAMonitoringFormCalculateScore],
		QAMonitoringForm.LastModified,
		CONVERT(CHAR(10),QAMonitoringForm.lastmodified,101) + ' ' +
		CONVERT(CHAR(5),QAMonitoringForm.lastmodified,108) as LastModifiedString,
		QAMonitoringFormCalculateScore
	
		
	
	FROM 
					  
                      QAMonitoringForm
	WHERE 
		QAMonitoringForm.QAMonitoringFormID = IsNull(@QAMonitoringFormID, QAMonitoringForm.QAMonitoringFormID)
		
		


	RETURN @@Error
GO


 