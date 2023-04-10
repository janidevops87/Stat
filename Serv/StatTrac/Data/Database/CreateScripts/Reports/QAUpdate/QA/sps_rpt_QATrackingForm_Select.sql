IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QATrackingForm_Select')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QATrackingForm_Select'
		DROP  Procedure  sps_rpt_QATrackingForm_Select
	END

GO

PRINT 'Creating Procedure sps_rpt_QATrackingForm_Select'
GO
CREATE Procedure sps_rpt_QATrackingForm_Select
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
**		File: sps_rpt_QATrackingForm_Select.sql
**		Name: sps_rpt_QATrackingForm_Select.sql
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
**		08/18/2009		ccarroll		added case statement to count form errors
**		10/06/2009		ccarroll		added PATINDEX to @Personids selection in WHERE 
**		5/10			sdabiri			Added QAMonitoringFormName Field
**		06/02/2010		jegerberich		Removed QATrackingEventDateTime field to avoid dups
**										HS 23872
**		09/27/2010		jegerberich		Added @TrackingTypeID variable and WHERE logic to 
**										accomodate the parameter in filtering results. HS 25264
**		09/29/2010		jegerberich		Modified WHERE clause to use QATrackingReferralDateTime
**										instead of QATrackingEventDateTime so that records are 
**										categorized into the proper months.  HS 25519 VS 7959
**		04/13/2012		ccarroll		Added required fields for link to QAReview Report
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
	QAMonitoringformname,
	CASE
		WHEN
			IsNull(QAErrorLogPointsYes,0) = 1
		AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1
		THEN 1
		WHEN
			IsNull(QAErrorLogPointsNo, 0) = 1
		AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1
		THEN 1
		ELSE 0
	END AS QAErrorLogNumberOfErrors,
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
				person.personid = qatrackingform.personid
	) AS Employee,
	(
		SELECT
			IsNull(Person.PersonFirst, '') 
		FROM
			person
		WHERE
			person.personid = qatrackingform.personid
	) AS EmployeeFirst,
	(
		SELECT
			IsNull(Person.PersonLast, '')
		FROM
			person
		WHERE
			person.personid = qatrackingform.personid
	) AS EmployeeLast,
	datepart(month,QATrackingReferralDateTime) AS refmonthnum,
	datename(month,QATrackingReferralDateTime) AS refmonth,
	datename(year,QATrackingReferralDateTime) AS refyear,
	datepart(month,QAErrorLogDateTime) AS errmonthnum,
	datename(month,QAErrorLogDateTime) AS errmonth,
	datename(year,QAErrorLogDateTime) AS erryear,
	(
		SELECT
			qaprocessstepdescription
		FROM
			qaprocessstep
		WHERE
			qaprocessstepid = qatrackingform.qaprocessstepid
	) AS ProcessStep,
	(
		SELECT
			qaerrortypedescription
		FROM
			qaerrortype
		WHERE
			qaerrortypeid = qaerrorlog.qaerrortypeid
	) AS Errortype,
	(
		SELECT
			qaerrorlocationdescription
		FROM
			qaerrorlocation
		WHERE
			qaerrorlocationid = qaerrorlog.qaerrorlocationid
	) AS ErrorLocation,

	/* Added columns for URL query string */
	QATrackingType.QATrackingTypeDescription,
	ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
	QATrackingForm.PersonID,
	QAMonitoringForm.QAMonitoringFormID,
	QATrackingForm.QATrackingFormID,
	CASE WHEN IsNull(QATracking.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
	ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS CompletedBy,
	QATracking.QATrackingID,
	QAMonitoringForm.QATrackingTypeID

FROM
	QATrackingForm
	INNER JOIN QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID
	INNER JOIN QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID
	INNER JOIN QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID
	INNER JOIN QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
	Left Join QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
	Left Join QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
	--LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID

	/* Added joins for URL query string */
	LEFT JOIN dbo.QATrackingType
	ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
	LEFT JOIN dbo.Person
	ON dbo.QATrackingForm.PersonID = Person.PersonID
	LEFT JOIN dbo.Person AS CompletedBy
	ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
                      
WHERE 
QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
--AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND IsNull(QATrackingSourceCode,0) = IsNull(@SourceCodeName,IsNull(QATrackingSourceCode,0))
AND QAErrorLog.QAErrorLocationID = IsNull(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
AND IsNull(QAErrorLogHowIdentifiedid,0) = IsNull(@HowIdentifiedID, IsNull(QAErrorLogHowIdentifiedid,0))
AND QATrackingform.QAProcessStepID = IsNull(@ProcessStepID, QATrackingform.QAProcessStepID)
AND QAErrorLog.QAErrorTypeID = IsNull(@ErrorTypeID, QAErrorLog.QAErrorTypeID)	
AND QATrackingReferralDateTime BETWEEN IsNull(@CallStartDateTime, '01/01/1901') AND IsNull(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN IsNull(@ErrorStartDateTime, '01/01/1901') AND IsNull(@ErrorEndDateTime, '12/31/2100')
AND QAErrorLogNumberOfErrors BETWEEN IsNull(@ZeroErrors, 0) AND IsNull(@ZeroErrors, 99999)
--AND qatrackingform.personid IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(qatrackingform.personid AS VarChar)+ '%', IsNull(@Personids, CAST(qatrackingform.personid AS VarChar))) > 0
--AND	QATracking.QATrackingTypeID = IsNull(@TrackingTypeID, QATracking.QATrackingTypeID)


GO