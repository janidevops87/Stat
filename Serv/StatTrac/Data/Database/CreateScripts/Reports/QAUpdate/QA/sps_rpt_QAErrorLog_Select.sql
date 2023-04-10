IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAErrorLog_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAErrorLog_Select'
		DROP  Procedure  sps_rpt_QAErrorLog_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_QAErrorLog_Select'
GO
CREATE Procedure sps_rpt_QAErrorLog_Select
	@ErrorLocationID			Int = Null,
	@ProcessStepID				Int = Null,
	@ErrorTypeID				Int = Null,
	@TrackingTypeID				Int = Null,
	@HowIdentifiedID			Int = null,
	@ZeroErrors					Int = Null,
	@Personids	 				VarChar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				Int = Null,
	@OrganizationID				Int = Null,
	@SourceCodeName				VarChar(10) = Null,
	@DisplayMT					Int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAErrorLog_Select.sql
**		Name: sps_rpt_QAErrorLog_Select.sql
**		Desc: 
**
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**		See above
**
**		Auth: jth
**		Date: 06/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:			Description:
**		--------		--------		-------------------------------------------
**      6/2009			jth				Initial release
**		08/18/2009		ccarroll		removed un-necessary joins
**		10/06/2009		ccarroll		added PATINDEX to @Personids selection in WHERE 
**      3/10            jth				added tracking type parm 
**		5/2010			sdabiri			Added MonitoringFormNameField
**		06/02/2010		jegerberich		Removed QATrackingEventDateTime field to avoid dups
**										HS 23872
**		04/13/2012		ccarroll		Added required fields for link to QAReview Report CCRST143
**		04/19/2012		ccarroll		Added CASE statement for QAMonitoringFormName CCRST143 -wi 1299
**		04/20/2012		ccarroll		Change order of Employee name to be Last, First to match selection criteria CCRST143 -wi 1300
**		04/26/2012		ccarroll		Added JOIN to WebReportGroupOrg for ASP users CCRST143
**		02/28/2013		jth				removed webreportgrouporg change above
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON

SELECT
	QATrackingSourceCode AS SourceCode,
	QATrackingReferralDateTime AS CallDateTime,
	QATrackingNumber,
	CASE WHEN QAMonitoringFormName is null THEN 'N/A' ELSE QAMonitoringFormName END AS QAMonitoringFormName,
	QAErrorLogNumberOfErrors,
	QAerrorlogComments,
	(
		SELECT
			QAErrorLogHowIdentifiedDescription
		FROM
			QAErrorLogHowIdentified
		WHERE
			QAErrorLogHowIdentifiedid = qaerrorlog.QAErrorLogHowIdentifiedid
	) AS HowIdentified,
	(
		SELECT
			IsNull(Person.PersonLast, '') + ', ' + IsNull(Person.PersonFirst, '')
		FROM
			person
		WHERE
			person.personid = QAErrorLog.QAErrorLogPersonID
	) AS Employee,
	(
		SELECT
			IsNull(Person.PersonFirst, '') 
		FROM
			person
		WHERE
			person.personid = QAErrorLog.QAErrorLogPersonID
	) AS EmployeeFirst,
	(
		SELECT
			IsNull(Person.PersonLast, '')
		FROM
			person
		WHERE
			person.personid = QAErrorLog.QAErrorLogPersonID
	) AS EmployeeLast,
	datepart(month,QATrackingReferralDateTime) AS refmonthnum,
	datename(month,QATrackingReferralDateTime) AS refmonth,
	datename(year,QATrackingReferralDateTime) AS RefYear,
	datepart(month,QAErrorLogDateTime) AS errmonthnum,
	datename(month,QAErrorLogDateTime) AS errmonth,
	datename(year,QAErrorLogDateTime) AS ErrYear,
	(
		SELECT
			qaprocessstepdescription
		FROM
			qaprocessstep
		WHERE
			qaprocessstepid = QAErrorLog.QAProcessStepID
	) AS ProcessStep,
	(
		SELECT
			qaerrortypedescription
		FROM
			qaerrortype
		WHERE
			qaerrortypeid = qaerrorlog.qaerrortypeid) AS ErrorType,
	(
		SELECT
			qaerrorlocationdescription
		FROM
			qaerrorlocation
		WHERE
			qaerrorlocationid = qaerrorlog.qaerrorlocationid
	) AS ErrorLocation,
	/* Added columns for URL query string */
	--QATrackingType.QATrackingTypeDescription,
	(select QATrackingType.QATrackingTypeDescription from  QATrackingType where  QATrackingType.QATrackingTypeID=(select QAErrorType.QATrackingTypeID from QAErrorType where QAErrorType.QAErrorTypeID = QAErrorLog.QAErrorTypeID)) as  'TrackingTypeDesc',
	ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
	QATrackingForm.PersonID,
	QAMonitoringForm.QAMonitoringFormID,
	QATrackingForm.QATrackingFormID,
	CASE WHEN IsNull(QATracking.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
	ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS CompletedBy,
	QATracking.QATrackingID,
	QAMonitoringForm.QATrackingTypeID

FROM
	QAErrorLog 
	INNER JOIN QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
	Left Join QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
	Left Join QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
                      --QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      --QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
	/* Added joins for URL query string */
	--LEFT JOIN dbo.QATrackingType ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
	LEFT JOIN dbo.QATrackingFormErrors ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm ON QATrackingForm.QATrackingFormID = dbo.QATrackingFormErrors.QATrackingFormID
	LEFT JOIN dbo.Person
	ON dbo.QATrackingForm.PersonID = Person.PersonID
	LEFT JOIN dbo.Person AS CompletedBy
	ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
    --LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
WHERE 
QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
--AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND IsNull(QATrackingSourceCode,0) = IsNull(@SourceCodeName,IsNull(QATrackingSourceCode,0))
AND QAErrorLog.QAErrorLocationID = IsNull(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
AND IsNull(QAErrorLogHowIdentifiedid,0) = IsNull(@HowIdentifiedID, IsNull(QAErrorLogHowIdentifiedid,0))
AND QAErrorLog.QAProcessStepID = IsNull(@ProcessStepID, QAErrorLog.QAProcessStepID)
AND QAErrorLog.QAErrorTypeID = IsNull(@ErrorTypeID, QAErrorLog.QAErrorTypeID)
--AND qatracking.QATrackingTypeID = IsNull(@TrackingTypeID, qatracking.QATrackingTypeID)	
AND QATrackingReferralDateTime BETWEEN IsNull(@CallStartDateTime, '01/01/1901') AND IsNull(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN IsNull(@ErrorStartDateTime, '01/01/1901') AND IsNull(@ErrorEndDateTime, '12/31/2100')
AND QAErrorLogNumberOfErrors BETWEEN IsNull(@ZeroErrors, 0) AND IsNull(@ZeroErrors, 99999)
--AND QAErrorLog.StatEmployeeID IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(QAErrorLog.QAErrorLogPersonID AS VarChar)+ '%', IsNull(@Personids, CAST(QAErrorLog.QAErrorLogPersonID AS VarChar))) > 0




GO