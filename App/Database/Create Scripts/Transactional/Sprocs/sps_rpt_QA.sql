IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QA')
	DROP  Procedure  sps_rpt_QA;
	PRINT 'Dropping Procedure: sps_rpt_QA'
GO
	PRINT 'Creating Procedure: sps_rpt_QA'
GO

CREATE Procedure dbo.sps_rpt_QA
(
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@HowIdentifiedID			int = null,
	@ZeroErrors					int = Null,
	@Personids	 				varchar(8000) = NULL,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null
)
AS

/******************************************************************************
**		File: sps_rpt_QA.sql
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  6/2009			jth					Initial release
**	08/14/2009		ccarroll			Created temp table. split sproc into two locations,
**										one for TrackingForm and one for Error Log.
**										Added WHERE to only show errors.
**	5/2010			Sue Dabiri			Added QAMonitoring Form Name Field
**	06/02/2010		James Gerberich		Removed QATrackingEventDateTime field and added Distinct to 
**										final select statement to avoid dups in report.  HS 23872
**	09/27/2010		jegerberich			Added @TrackingTypeID variable and WHERE logic to 
**										accomodate the parameter in filtering results. HS 25264
**  10/2011         jth					fixed table variable for errmonth, erryear, refmonnum and refyear to be varchar
**	04/13/2012		ccarroll			Added required fields for link to QAReview Report
**	08/14/2013		Tanvir Ather		Bug # 7724
**	09/19/2013		ccarroll			HS 37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014		ccarroll			HS 38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime
**  10/14/2014		mberenson			Reverted back to keying on el.QAErrorLogDateTime AS CallDateTime
**  10/17/2014		mberenson			Added ErrMonth to the select list
**	10/22/2014		mberenson			Added EventMonthNum, EventMonth, & EventYear to the select list
**	10/28/2014		mberenson			Added coalesce function with QAErrorLogDateTime to new EventMonthNum, EventMonth, & Event Year fields
**  10/28/2014		mberenson			Set coalesce function to key on QAErrorLogDateTime first and QATrackingEventDateTime second
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
 
SELECT
	t.QATrackingSourceCode AS SourceCode,
	coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime) AS CallDateTime,
	t.QATrackingNumber,
	coalesce(mf.QAMonitoringFormName, 'N/A') AS QAMonitoringFormName,
	el.QAErrorLogNumberOfErrors,
	el.QAerrorlogComments,
	HowIdentified.QAErrorLogHowIdentifiedDescription AS HowIdentified,
	coalesce(Employee.PersonLast + ' ', '') + coalesce(Employee.PersonFirst, '') AS Employee,
	coalesce(Employee.PersonFirst, '') AS EmployeeFirst,
	coalesce(Employee.PersonLast, '') AS EmployeeLast,
	datepart(month, t.QATrackingReferralDateTime) AS RefMonthNum,
	datename(month, t.QATrackingReferralDateTime) AS RefMonth,
	datename(year, t.QATrackingReferralDateTime) AS RefYear,
	datepart(month, el.QAErrorLogDateTime) AS ErrMonthNum,
	datename(month, el.QAErrorLogDateTime) AS ErrMonth,
	datename(year, el.QAErrorLogDateTime) AS ErrYear,
	datepart(month, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) AS EventMonthNum,
	datename(month, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) AS EventMonth,
	datename(year, coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime)) As EventYear,
	coalesce(tfps.QAProcessStepDescription, elps.QAProcessStepDescription) AS ProcessStep,
	et.QAErrorTypeDescription AS ErrorType,
	eloc.QAErrorLocationDescription AS ErrorLocation,
	tt.QATrackingTypeDescription AS QATrackingTypeDescription,
	coalesce(Employee.PersonFirst + ' ', '') + coalesce(Employee.PersonMI + ' ', '') + coalesce(Employee.PersonLast, '') AS EmployeeFullName,
	Employee.PersonID,
	mf.QAMonitoringFormID,
	tf.QATrackingFormID,
	CASE WHEN coalesce(t.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
	coalesce(CompletedBy.PersonFirst + ' ', '') + coalesce(CompletedBy.PersonMI + ' ', '') + coalesce(CompletedBy.PersonLast, '') AS CompletedBy,
	t.QATrackingID,
	coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) AS QATrackingTypeID
FROM dbo.QATracking t
	INNER JOIN dbo.QAErrorLog el ON t.QATrackingID = el.QATrackingID
	LEFT JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	LEFT JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID

	-- Joins to get diplay data
	-- HowIdentified
	LEFT JOIN dbo.QAErrorLogHowIdentified HowIdentified ON el.QAErrorLogHowIdentifiedID = HowIdentified.QAErrorLogHowIdentifiedID
	-- Employee, EmployeeFirst, EmployeeLast, EmployeeFullName, PersonID
	LEFT JOIN dbo.Person AS Employee ON el.QAErrorLogPersonID = Employee.PersonID
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	LEFT JOIN dbo.QAProcessStep tfps ON tf.QAProcessStepID = tfps.QAProcessStepID
	LEFT JOIN dbo.QAProcessStep elps ON el.QAProcessStepID = elps.QAProcessStepID
	-- Errortype
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
	-- TrackingTypeDesc
	LEFT JOIN dbo.QATrackingType tt ON mf.QATrackingTypeID = tt.QATrackingTypeID
	-- CompletedBy
	LEFT JOIN dbo.Person AS CompletedBy ON el.StatEmployeeID = CompletedBy.PersonID
WHERE
	el.QAErrorLocationID = coalesce(@ErrorLocationID, el.QAErrorLocationID)
	AND coalesce(tf.QAProcessStepID,el.QAProcessStepID) = coalesce(@ProcessStepID, tf.QAProcessStepID,el.QAProcessStepID)
	AND coalesce(mft.QAErrorTypeID, 0) = coalesce(@ErrorTypeID, mft.QAErrorTypeID, 0)	
	AND coalesce(el.QAErrorLogHowIdentifiedID, 0) = coalesce(@HowIdentifiedID, coalesce(el.QAErrorLogHowIdentifiedID,0))
	 --Ignore @ZeroErrors and Only show items with more than zero error 
	AND el.QAErrorLogNumberOfErrors > 0
	AND PATINDEX('%' + CAST(coalesce(Employee.personid, '') AS VarChar)+ '%', coalesce(@Personids, CAST(coalesce(Employee.personid, '') AS varchar))) > 0
AND coalesce(el.QAErrorLogDateTime, tf.QATrackingEventDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND coalesce(t.QATrackingSourceCode, '-') = coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '-'))
	-- @DisplayMT : Not sure why this is not implemented
ORDER BY t.QATrackingNumber, Employee.PersonLast, eloc.QAErrorLocationDescription;

