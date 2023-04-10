 IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetQAGridErrorTypesByEmployee]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetQAGridErrorTypesByEmployee]
	PRINT 'Dropping Procedure: GetQAGridErrorTypesByEmployee'
END
	PRINT 'Creating Procedure: GetQAGridErrorTypesByEmployee'
GO

CREATE PROCEDURE [dbo].[GetQAGridErrorTypesByEmployee]
(
	@OrganizationID int = NULL,
	@QATrackingNumber varchar(20) = NULL,
	@TrackingTypeID int = NULL
)
/******************************************************************************
**		File: GetQAGridErrorTypesByEmployee.sql
**		Name: GetQAGridErrorTypesByEmployee
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
**      02/09       jth			fixed to use correct parms,joining to statemployee by wrong id, added PersonID and QAErrorLocation.QAErrorLocationID
**      03/09       jth         sql did not summarize
**      04/09       jth         change with new tracking tables
**      02/10       jth         don't join to tracking form table any longer and added trackingid
**      03/10       jth         search with trackingtypeid and exclude forms
**	   04/2010		bret			updating to include in release
**      04/10       jth         added numberoferrors > 0 and if form template is null criteria 
**      5/13		jth			only show errors related to tracking type
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

	SELECT
				IsNull(Person.PersonFirst, '') + ' ' + IsNull(Person.PersonLast, '') AS 'StatEmployeeName',
				--QAErrorLog.QAErrorTypeID,
				Person.PersonID,QAErrorLog.QATrackingID,
				QAErrorLocation.QAErrorLocationID,
				QAErrorLocation.QAErrorLocationDescription,qaerrortype.QATrackingTypeID,QATrackingNumber,
				Sum(QAErrorLog.QAErrorLogNumberOfErrors) as QAErrorLogNumberOfErrors
				
	FROM		 QAErrorLog INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID INNER JOIN
                      Person ON QAErrorLog.QAErrorLogPersonID = Person.PersonID LEFT OUTER JOIN
                      QAErrorLocation ON QAErrorLog.QAErrorLocationID = QAErrorLocation.QAErrorLocationID left outer join
					  qaerrortype on qaerrorlog.QAErrorTypeID = qaerrortype.QAErrorTypeID
	WHERE
			QAErrorLocation.OrganizationID = IsNull(@OrganizationID,QAErrorLocation.OrganizationID) and
			QATracking.QATrackingNumber = @QATrackingNumber and
			--QATracking.QATrackingTypeID = @TrackingTypeID and
			(QAErrorLog.QAErrorLogNumberOfErrors > 0 or QAMonitoringFormTemplateID is null) and
			QAErrorType.QATrackingTypeID = @TrackingTypeID
			--and QAMonitoringFormTemplateID is null
GROUP BY Person.PersonID, QAErrorLog.QATrackingID, Person.PersonLast, Person.PersonFirst, QAErrorLocation.QAErrorLocationID, QAErrorLocation.QAErrorLocationDescription,qaerrortype.QATrackingTypeID,QATrackingNumber
order by Person.personlast,QAErrorLocation.QAErrorLocationDescription			
			

	RETURN @@Error
GO
 