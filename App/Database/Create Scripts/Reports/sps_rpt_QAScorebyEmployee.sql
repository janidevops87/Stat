IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sps_rpt_QAScorebyEmployee]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sps_rpt_QAScorebyEmployee]
GO

SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

CREATE Procedure [dbo].[sps_rpt_QAScorebyEmployee]
	
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,
	@Personids	 				varchar(8000) = NULL,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAScorebyEmployee.sql
**		Name: sps_rpt_QAScorebyEmployee.sql
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
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  6/2009			jth			Initial release
**	08/17/2009		ccarroll	Added SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
**	10/06/2009		ccarroll	added PATINDEX to @Personids selection in WHERE
**	10/07/2009		ccarroll	removed QAErrorTypeGenerateLogIfYes from WHERE
**  3/10			jth			added tracking type parm  
**	5/10			sdabiri		Added Field QAMonitoring form and changed how the tables
**									are joined.
**  11/10           jth			added qaerrorlogpersonid is not null to where clause
**	04/12/2012		ccarroll	Added required fields for link to QAReview Report
**	04/20/2012		ccarroll	Change order of Employee name to be Last, First to match selection criteria CCRST143 -wi 1300
**	04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013		jth			removed webreportgrouporg change above
**	03/07/2013		jth			added criteria to not return forms that have a do not calculate score
**  6/13			jth			call date is now from the error log file/field error log date (this is the actual date of the error)
**	09/10/2013		ccarroll	re-organized table joins and where clause
**	01/08/2014		ccarroll	HS 38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime
**  10/14/2014		mberenson	Reverted back to keying on el.QAErrorLogDateTime AS CallDateTime
**	10/22/2014		mberenson	Added EventMonthNum, EventMonth, & EventYear to the select list
**	10/28/2014		mberenson	Added coalesce function with QAErrorLogDateTime to new EventMonthNum, EventMonth, & Event Year fields
**  10/28/2014		mberenson	Key on tf.QATrackingEventDateTime for date filtering & return logic
**	02/05/2020		mberenson	No changes - comment needed for sql build after rollback
*******************************************************************************/ 
--Declare @CallStartDateTime		    DateTime 
--Declare	@CallEndDateTime		    DateTime 
--Declare	@ErrorStartDateTime		    DateTime 
--Declare	@ErrorEndDateTime			DateTime 
--Declare	@TrackingTypeID				int 
--Declare	@Personids	 				varchar(8000) 
--Declare	@ReportGroupID				int 
--Declare	@OrganizationID				int 
--Declare	@SourceCodeName				varchar(10) 
--Declare	@DisplayMT					int 

--set @CallStartDateTime = '5/1/2010'
--set @CallEndDateTime = '5/3/2010'
--set @ReportGroupID = 38
--set @TrackingTypeID = 1 --StatTrac
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT DISTINCT 
tf.QATrackingFormID, 
t.QATrackingSourceCode as SourceCode, 
tf.QATrackingEventDateTime AS CallDateTime,
t.QATrackingNumber,
mf.QAMonitoringFormName, 
tf.QATrackingEventDateTime, 
t.QATrackingReferralTypeID, 
tf.QATrackingFormPoints,
(SELECT     ISNULL(Person.PersonLast, '') + ', ' + ISNULL(Person.PersonFirst, '')
                            FROM          person
                            WHERE      person.personid = tf.personid) AS Employee,
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = tf.personid) AS EmployeeFirst,
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid) AS EmployeeLast,
datepart(month,QATrackingReferralDateTime) as refmonthnum,datename(month,QATrackingReferralDateTime) as refmonth,datename(year,QATrackingReferralDateTime) as refyear,
datepart(month,QAErrorLogDateTime) as errmonthnum,datename(month,QAErrorLogDateTime) as errmonth,datename(year,QAErrorLogDateTime) as erryear,
                      case when	QATrackingNumber NOT LIKE '%[A-Z]%'  then
			case when        LEN(QATrackingNumber) < 10 then
                          (SELECT     TOP 1 ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName)
                            FROM          ReferralType INNER JOIN
                                                   Referral ON ReferralType.ReferralTypeID = Referral.ReferralTypeID INNER JOIN
                                                   WebReportGroupOrg ON Referral.ReferralCallerOrganizationID = WebReportGroupOrg.OrganizationID RIGHT OUTER JOIN
                                                   MessageType INNER JOIN
                                                   Message ON MessageType.MessageTypeID = Message.MessageTypeID RIGHT OUTER JOIN
                                                   CallType INNER JOIN
                                                   Call INNER JOIN
                                                   SourceCode ON Call.SourceCodeID = SourceCode.SourceCodeID ON CallType.CallTypeID = Call.CallTypeID ON 
                                                   Message.CallID = Call.CallID ON Referral.CallID = Call.CallID
                            WHERE      call.callid  = QATrackingNumber) end
			    else 'N/A' end AS CallTypeName,

			/* Added columns for URL query string */
			tt.QATrackingTypeDescription,
			ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
			tf.PersonID,
			mf.QAMonitoringFormID,
			CASE WHEN IsNull(t.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
			ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS CompletedBy,
			t.QATrackingID,
			datename(month, el.QAErrorLogDateTime) AS ErrMonth,
			datepart(month, tf.QATrackingEventDateTime) AS EventMonthNum,
			datename(month, tf.QATrackingEventDateTime) AS EventMonth,
			datename(year, tf.QATrackingEventDateTime) As EventYear

			    
FROM dbo.QAErrorLog el
	INNER JOIN dbo.QATracking t ON t.QATrackingID = el.QATrackingID
	INNER JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	INNER JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID
	-- Joins to get diplay data
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	--TrackingTypeDesc
	LEFT JOIN dbo.QATrackingType tt ON mf.QATrackingTypeID = tt.QATrackingTypeID
	-- CompletedBy
	-- Employee, EmployeeFirst, EmployeeLast, EmployeeFullName, PersonID
	LEFT JOIN dbo.Person AS Person ON tf.PersonID = Person.PersonID 
	LEFT JOIN dbo.Person AS CompletedBy ON el.StatEmployeeID = CompletedBy.PersonID
			            

WHERE 
	t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND PATINDEX(coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '')), coalesce(t.QATrackingSourceCode, '')) > 0
	AND PATINDEX('%' + CAST(tf.personid AS varchar)+ '%', IsNull(@Personids, CAST(tf.personid AS varchar))) > 0
	AND mf.QATrackingTypeID = coalesce(@TrackingTypeID, mf.QATrackingTypeID)	
	AND tf.QATrackingEventDateTime BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND el.qaerrorlogpersonid is not null
	AND QAMonitoringFormCalculateScore = 1;

GO