IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAMonitoringForm]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAMonitoringForm];
	PRINT 'Dropping Procedure: GetQAMonitoringForm';
END
	PRINT 'Creating Procedure: GetQAMonitoringForm';
GO

CREATE PROCEDURE [dbo].[GetQAMonitoringForm]
(
	@QAMonitoringFormID int = NULL,
	@OrganizationID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@EmployeeID int = NULL

)
/******************************************************************************
**		File: GetQAMonitoringForm.sql
**		Name: GetQAMonitoringForm
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
**      02/09       jth         added employeeid and trackingnumber parm; added joing to tracking table, rework selected fields
**      03/09       jth         added military time string 
**      04/09       jth         reworked to use new tracking tables
**      03/10       jth         added trackingid for querystring
**	   04/2010		bret			updating to include in release
**		11/20/2019	bret		optimized where clauses
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED; 

	SELECT distinct
		QATrackingForm.QATrackingFormID,
		QATrackingEventDateTime,(select ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')from person where person.personid=statemployeeid) as CompletedBy,
		CONVERT(CHAR(10),QATrackingEventDateTime,101) + ' ' +
		CONVERT(CHAR(5),QATrackingEventDateTime,108) as LastModifiedString,
		QATrackingFormPoints,qatracking.QATrackingID,
		(select qaprocessstepdescription from qaprocessstep where qaprocessstep.qaprocessstepid = qatrackingform.qaprocessstepid) as QAProcessStepDescription
		
	
	FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID INNER JOIN
                      QATrackingFormErrors ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID INNER JOIN
                      QATrackingForm ON QATrackingFormErrors.QATrackingFormID = QATrackingForm.QATrackingFormID 
                      --AND  QAErrorLog.StatEmployeeID = QATrackingForm.PersonID
	WHERE 
		(@QAMonitoringFormID is null 
		or QAMonitoringFormTemplate.QAMonitoringFormID = @QAMonitoringFormID)
	AND (@OrganizationID is null
		or OrganizationID = @OrganizationID)
	and (@QATrackingNumber is null 
		or QATracking.QATrackingNumber = @QATrackingNumber)
	and (@EmployeeID is null 
		or PersonID = @EmployeeID)
	and QAErrorLog.qaerrorlogpersonid is not NULL;

	RETURN @@Error;
GO


