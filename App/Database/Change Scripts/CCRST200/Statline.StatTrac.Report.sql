PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:1/22/2014 10:58:26 AM-- Removed Triaged detail For CCRST-200 QA Hot Fix release 
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/sps_rpt_QA.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAApproved/QAApproved.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyCAPA/sps_rpt_QAbyCAPA.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyError/sps_rpt_QAbyError.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyTrackingNumber/sps_rpt_QAbyTrackingNumber.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAFormsCompletedBy/sps_rpt_QAFormsCompletedBy.sql
-- D:\Statline\StatTrac/Serv/Dev/StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAScorebyEmployee/sps_rpt_QAScorebyEmployee.sql

PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QA\sps_rpt_QA.sql'
GO
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
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;
 
SELECT
	t.QATrackingSourceCode AS SourceCode,
	coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) AS CallDateTime,
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
	datename(month, el.QAErrorLogDateTime) AS ErrYear,
	datename(year, el.QAErrorLogDateTime) AS erryear,
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
AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND coalesce(t.QATrackingSourceCode, '-') = coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '-'))
	-- @DisplayMT : Not sure why this is not implemented
ORDER BY t.QATrackingNumber, Employee.PersonLast, eloc.QAErrorLocationDescription;

GO


GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAApproved\QAApproved.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAApproved'
		DROP  Procedure  sps_rpt_QAApproved
	END
GO
		PRINT 'Creating Procedure sps_rpt_QAApproved'
GO

CREATE Procedure sps_rpt_QAApproved
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,	
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**	File: sps_rpt_QAApproved.sql
**	Name: sps_rpt_QAApproved.sql
**	Desc: 
**
**              
**	Return values:
** 
**	Called by:   
**              
**	Parameters:
**	Input							Output
**    ----------							-----------
**	See above
**
**	Auth: jth
**	Date: 05/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:				Description:
**	--------		--------			-------------------------------------------
**  5/2009			jth			Initial release
**  3/10            jth			added tracking type parm 
**	04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013		jth			removed webreportgrouporg change above
**	09/09/2013		ccarroll	fixed table joins wi 7764
**	09/19/2013		ccarroll	HS 37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014		ccarroll	HS 38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT DISTINCT
(case  when len(t.QATrackingSourceCode) > 0  then t.QATrackingSourceCode else 'N/A' end)  SourceCode, 
 coalesce(el.QAErrorLogDateTime, t.QATrackingReferralDateTime) AS CallDateTime, 
 t.QATrackingNumber
FROM dbo.QAErrorLog el
	INNER JOIN dbo.QATracking t ON t.QATrackingID = el.QATrackingID
	INNER JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	INNER JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	-- Errortype
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE
	tf.QATrackingApproved = 1
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND t.QATrackingSourceCode = coalesce(@SourceCodeName, t.QATrackingSourceCode)
	-- @DisplayMT : Not sure why this is not implemented
ORDER BY 
1,2,3;

GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAbyCAPA\sps_rpt_QAbyCAPA.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	DROP  Procedure  sps_rpt_QAbyCAPA;
	PRINT 'Dropping Procedure: sps_rpt_QAbyCAPA'
GO
	PRINT 'Creating Procedure: sps_rpt_QAbyCAPA'
GO

CREATE Procedure sps_rpt_QAbyCAPA
	@TrackingNum				varchar(20) = Null,
	@CAPANum				varchar(20) = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,	
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAbyCAPA.sql
**		Name: sps_rpt_QAbyCAPA.sql
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
**		Date: 05/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:		Description:
**		--------		--------	-------------------------------------------
**      5/2009			jth			Initial release
**      08/09           jth			only display records with a capa number
**		10/03/2009		ccarroll	return all dates when @TrackingNum or @CAPANum used 
**      3/10            jth			added tracking type parm
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**		02/28/2013		jth			removed webreportgrouporg change above
**		09/09/2013		ccarroll	re-organized table joins and where clause
**		09/19/2013		ccarroll	HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**		01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

--if @SourceCodeName is null
--BEGIN
-- SET @SourceCodeName = ''
--END

If @TrackingNum IS NOT NULL OR @CAPANum IS NOT NULL
BEGIN
SELECT 
	@CallStartDateTime = Null,
	@CallEndDateTime = Null,
	@ErrorStartDateTime = Null,
	@ErrorEndDateTime = Null
END

SELECT DISTINCT
		tf.QATrackingFormID,
		(case  when len(tf.QATrackingCAPANumber) > 0  then tf.QATrackingCAPANumber else 'N/A' end) QATrackingCAPANumber, 
	    (case  when len(t.QATrackingSourceCode) > 0  then t.QATrackingSourceCode else 'N/A' end)  SourceCode, 
         coalesce(el.QAErrorLogDateTime, t.QATrackingReferralDateTime) AS CallDateTime, 
         t.QATrackingNumber

FROM dbo.QAErrorLog el
	INNER JOIN dbo.QATracking t ON t.QATrackingID = el.QATrackingID
	INNER JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	INNER JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID
	-- ProcessStep
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	-- Errortype
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
WHERE
	t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND PATINDEX(coalesce(@TrackingNum, t.QATrackingNumber), t.QATrackingNumber) > 0 
	AND PATINDEX(coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '')), coalesce(t.QATrackingSourceCode, '')) > 0
	AND PATINDEX(coalesce(@CAPANum,tf.QATrackingCAPANumber), tf.QATrackingCAPANumber)> 0
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND tf.QATrackingCAPANumber > '0'
ORDER BY 
2,3, 4;


GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAbyError\sps_rpt_QAbyError.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyError')
	DROP  Procedure  sps_rpt_QAbyError;
	PRINT 'Dropping Procedure: sps_rpt_QAbyError'
GO
	PRINT 'Creating Procedure: sps_rpt_QAbyError'
GO
 
 CREATE Procedure sps_rpt_QAbyError
(
	@ErrorLocationID			int = Null,
	@ProcessStepID				int = Null,
	@ErrorTypeID				int = Null,
	@TrackingTypeID				int = Null,
	@ZeroErrors					int = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null
)
AS
/******************************************************************************
**		File: sps_rpt_QAbyError.sql
*******************************************************************************
**		Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**  6/2009		jth				Initial release
**	09/18/2009	ccarroll		added WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
**	10/03/2009	ccarroll		added @ErrorTypeID to WHERE
**  3/10        jth				added tracking type parm
**	05/28/2010	JGerberich		Removed el.QAErrorTypeID replaced 
**								with QAMonitoringFormTemplate.QAErrorTypeID HS #23404
**	04/26/2012	ccarroll		Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013	jth				removed webreportgrouporg change above
**	08/14/2013	Tanvir Ather	Bug # 7722
**	10/01/2013	ccarroll		HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014	ccarroll		HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

SELECT
	coalesce(t.QATrackingSourceCode, '') AS SourceCode,
	CASE
		WHEN tf.QATrackingFormID IS NOT NULL 
		THEN
			CASE
				WHEN coalesce(el.QAErrorLogPointsYes,0) = 1 AND coalesce(et.QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				WHEN coalesce(el.QAErrorLogPointsNo, 0) = 1 AND coalesce(et.QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
				ELSE 0
			END
		ELSE el.QAErrorLogNumberOfErrors
	END AS QAErrorLogNumberOfErrors,
	coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) AS CallDateTime,
	t.QATrackingNumber, 
	DatePart(Month, t.QATrackingReferralDateTime) AS RefMonthNum,
	DateName(Month, t.QATrackingReferralDateTime) AS RefMonth,
	DateName(Year, t.QATrackingReferralDateTime) AS RefYear,
	DatePart(Month, el.QAErrorLogDateTime) AS ErrMonthNum,
	DateName(Month, el.QAErrorLogDateTime) AS ErrMonth,
	DateName(Year, el.QAErrorLogDateTime) AS ErrYear,
	coalesce(tfps.QAProcessStepDescription, elps.QAProcessStepDescription) AS ProcessStep,
	et.QAErrorTypeDescription AS ErrorType ,
	eloc.QAErrorLocationDescription AS ErrorLocation,
	coalesce(tf.QATrackingEventDateTime, el.QAErrorLogDateTime) AS QATrackingEventDateTime,
	@SourceCodeName,
	t.QATrackingSourceCode
FROM dbo.QATracking t
	INNER JOIN dbo.QAErrorLog el ON t.QATrackingID = el.QATrackingID
	LEFT JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	LEFT JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID

	-- QAErrorLogNumberOfErrors
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ProcessStep
	LEFT JOIN dbo.QAProcessStep tfps ON tf.QAProcessStepID = tfps.QAProcessStepID
	LEFT JOIN dbo.QAProcessStep elps ON el.QAProcessStepID = elps.QAProcessStepID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE
	el.QAErrorLocationID = coalesce(@ErrorLocationID, el.QAErrorLocationID)
	AND coalesce(tf.QAProcessStepID,el.QAProcessStepID) = coalesce(@ProcessStepID, tf.QAProcessStepID,el.QAProcessStepID)
	AND coalesce(mft.QAErrorTypeID, el.QAErrorTypeID)  = coalesce(@ErrorTypeID, mft.QAErrorTypeID, el.QAErrorTypeID)	
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	AND coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- Ignore @ZeroErrors and Only show items with more than zero error 
	AND el.QAErrorLogNumberOfErrors > 0
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	-- @ReportGroupID : Not sure why this is not implemented
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND coalesce(t.QATrackingSourceCode, '-') = coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '-'))

ORDER BY t.QATrackingNumber;

GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAbyTrackingNumber\sps_rpt_QAbyTrackingNumber.sql'
GO
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyTrackingNumber'
		DROP  Procedure  sps_rpt_QAbyTrackingNumber
	END

GO
	PRINT 'Creating Procedure sps_rpt_QAbyTrackingNumber'
GO
 
 CREATE Procedure sps_rpt_QAbyTrackingNumber
	@TrackingNum				varchar(20) = Null,
	@CallStartDateTime		    DateTime = Null,
	@CallEndDateTime		    DateTime = Null,
	@ErrorStartDateTime		    DateTime = Null,
	@ErrorEndDateTime			DateTime = Null,
	@TrackingTypeID				int = Null,
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**	File: sps_rpt_QAbyTrackingNumber.sql
**	Name: sps_rpt_QAbyTrackingNumber.sql
**	Desc: 
**
**              
**	Return values:
** 
**	Called by:   
**              
**	Parameters:
**	Input							Output
**  ----------							-----------
**	See above
**
**	Auth: jth
**	Date: 05/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:		Description:
**	--------		--------	-------------------------------------------
**   5/2009			jth			Initial release
**	08/018/2009		ccarroll	added CASE statement for error counts
**	09/21/2009		ccarroll	Change WHERE clause to include Tracking Numbers which
**								have errors defined by GenerateLogIfYes and GenerareLogIfNo options.
**	10/03/2009		ccarroll	changed QAErrorLogCorrection to CorrectionLog to match sort option
**	5/10			Sue Dabiri	Added QAMonitoringForm Name field
**	04/19/2012		ccarroll	Added CASE statement for QAMonitoringFormName CCRST143 -wi 1299
**	04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**	02/28/2013		jth			removed webreportgrouporg change above
**	09/19/2013		ccarroll	HS37316, #8469 Use ErrorType When Monitoring Form TrackingTypeID is Null
**	01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/ 
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   null
	END
			

SELECT DISTINCT 
	tf.QATrackingFormID,
	coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) AS QATrackingReferralDateTime,  
    t.QATrackingNumber,
	CASE WHEN QAMonitoringFormName is null THEN 'N/A' ELSE QAMonitoringFormName END AS QAMonitoringFormName,
	CASE WHEN (tf.qatrackingformid)is not null THEN
			CASE WHEN coalesce(QAErrorLogPointsYes,0) = 1 AND coalesce(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN coalesce(QAErrorLogPointsNo, 0) = 1 AND coalesce(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END
	ELSE el.QAErrorLogNumberOfErrors END AS QAErrorLogNumberOfErrors,
case when (tf.qatrackingformid)is not null then                      
 (SELECT     coalesce(Person.PersonFirst, '') + ' ' + coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid)
else
(SELECT     coalesce(Person.PersonFirst, '') + ' ' + coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS Employee,
case when (tf.qatrackingformid)is not null then
 (SELECT     coalesce(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = tf.personid) 
else
 (SELECT     coalesce(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
AS EmployeeFirst,
case when (tf.qatrackingformid)is not null then
 (SELECT     coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid)
else
(SELECT     coalesce(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS EmployeeLast,
case when (tf.qatrackingformid)is not null then
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = tf.qaprocessstepid)
else
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = el.qaprocessstepid)
end
 AS ProcessStep,

                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = el.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = el.qaerrorlocationid) AS ErrorLocation,
                          (SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = el.QAErrorLogHowIdentifiedid) AS HowIdentified,
el.QAErrorLogDateTime,
el.QAerrorlogComments,
el.QAErrorLogTicketNumber,
el.QAErrorLogCorrection AS CorrectionLog
FROM dbo.QATracking t
	INNER JOIN dbo.QAErrorLog el ON t.QATrackingID = el.QATrackingID
	LEFT JOIN dbo.QAMonitoringFormTemplate mft ON el.QAMonitoringFormTemplateID = mft.QAMonitoringFormTemplateID
	LEFT JOIN dbo.QAMonitoringForm mf ON mft.QAMonitoringFormID = mf.QAMonitoringFormID

	-- QAErrorLogNumberOfErrors
	LEFT JOIN dbo.QATrackingFormErrors tfe ON tfe.QAErrorLogID = el.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm tf ON tf.QATrackingFormID = tfe.QATrackingFormID
	LEFT JOIN dbo.QAErrorType et ON el.QAErrorTypeID = et.QAErrorTypeID
	-- ProcessStep
	LEFT JOIN dbo.QAProcessStep ps ON tf.QAProcessStepID = ps.QAProcessStepID
	-- ErrorLocation
	LEFT JOIN dbo.QAErrorLocation eloc ON el.QAErrorLocationID = eloc.QAErrorLocationID
WHERE 
	--TrackingTypeID need to be matched against both QAMonitoringForm and QAErrorType (mf and et)
	coalesce(mf.QATrackingTypeID, et.QATrackingTypeID) = coalesce(@TrackingTypeID, coalesce(mf.QATrackingTypeID, et.QATrackingTypeID))
	-- Ignore @ZeroErrors and Only show items with more than zero error 
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	-- @ReportGroupID : Not sure why this is not implemented
	AND coalesce(t.OrganizationID, 0) = coalesce(@OrganizationID, t.OrganizationID,0)
	AND coalesce(t.QATrackingSourceCode, '') = coalesce(@SourceCodeName, t.QATrackingSourceCode, '')
	AND QATrackingNumber = coalesce(@TrackingNum,QATrackingNumber)
	AND (
			(coalesce(QAErrorLogPointsYes,0) = 1 AND coalesce(QAErrorTypeGenerateLogIfYes, 0) = 1)
		OR	(coalesce(QAErrorLogPointsNo, 0) = 1 AND coalesce(QAErrorTypeGenerateLogIfNo, 0) = 1)
		OR	(coalesce(QAErrorLogNumberOfErrors,0) > 0)
		);
GO



GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAFormsCompletedBy\sps_rpt_QAFormsCompletedBy.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAFormsCompletedBy')
      BEGIN
            PRINT 'Dropping Procedure sps_rpt_QAFormsCompletedBy'
            DROP  Procedure  sps_rpt_QAFormsCompletedBy
      END

GO

PRINT 'Creating Procedure sps_rpt_QAFormsCompletedBy'
GO

CREATE Procedure sps_rpt_QAFormsCompletedBy
      @TrackingNum                        varchar(20) = Null,
      @CompletedByID              int = Null,
      @CallStartDateTime                DateTime = Null,
      @CallEndDateTime            DateTime = Null,
      @ErrorStartDateTime               DateTime = Null,
      @ErrorEndDateTime             DateTime = Null,
      @TrackingTypeID				int = Null,      
      @ReportGroupID                      int = Null,
      @OrganizationID                     int = Null,
      @SourceCodeName                     varchar(10) = Null,
      
      @DisplayMT                          int = Null

AS
/******************************************************************************
**          File: sps_rpt_QAFormsCompletedBy.sql
**          Name: sps_rpt_QAFormsCompletedBy.sql
**          Desc: 
**
**              
**          Return values:
** 
**          Called by:   
**              
**          Parameters:
**          Input                                     Output
**     ----------                                     -----------
**          See above
**
**          Auth: jth
**          Date: 05/2009
*******************************************************************************
**          Change History
*******************************************************************************
**          Date:       Author:		Description:
**          --------    --------	-------------------------------------------
**      5/2009          jth         Initial release
**		09/18/2009		ccarroll	restored to original (production release)
**									modified to only return Form data.
**		10/03/2009		ccarroll	added date bypass for @TrackingNum
**      3/10			jth			added tracking type parm 
**      10/2011         jth			added filter to not return incomplete forms
**		04/13/2012		ccarroll	Added required fields for link to QAReview Report
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
**		02/28/2013		jth			removed webreportgrouporg change above
**		09/09/2013		ccarroll	re-arranged table joins and where clause
**		01/08/2014		ccarroll	HS38142 Added COALESCE in WHERE to look at both @CallStartDateTime  @ErrorStartDateTime 
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
SET NOCOUNT ON;

IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   Null
	END


SELECT DISTINCT tf.QATrackingFormID,
				tf.QATrackingFormPoints,
				t.QATrackingNumber,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = tf.personid) AS Employee,

				 el.StatEmployeeID,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid) AS CompletedBy,
				
				tf.PersonID,
                (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode,
                  case when   QATrackingNumber NOT LIKE '%[A-Z]%'  then
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
                            WHERE      call.callid  = ISNULL(@TrackingNum,QATrackingNumber)) end
                      else 'N/A' end AS CallTypeName,

					/* Added columns for URL query string */
					tt.QATrackingTypeDescription,
					ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
					mf.QAMonitoringFormID,
					mf.QAMonitoringFormName,
					CASE WHEN IsNull(t.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
					ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS QATrackingFormCompletedBy,
					t.QATrackingID


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
	-- Employee, EmployeeFirst, EmployeeLast, EmployeeFullName, PersonID
	LEFT JOIN dbo.Person AS Employee ON el.QAErrorLogPersonID = Employee.PersonID
	LEFT JOIN dbo.Person AS Person ON tf.PersonID = Person.PersonID 
	LEFT JOIN dbo.Person AS CompletedBy ON el.StatEmployeeID = CompletedBy.PersonID
WHERE
	tf.QATrackingFormID Is Not Null
	AND t.OrganizationID = coalesce(@OrganizationID, t.OrganizationID)
	AND PATINDEX(coalesce(@TrackingNum, t.QATrackingNumber), t.QATrackingNumber) > 0 
	AND PATINDEX(coalesce(@SourceCodeName, coalesce(t.QATrackingSourceCode, '')), coalesce(t.QATrackingSourceCode, '')) > 0
	AND mf.QATrackingTypeID = coalesce(@TrackingTypeID, mf.QATrackingTypeID)	
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND  StatEmployeeID = coalesce(@CompletedByID, StatEmployeeID)
	AND el.qaerrorlogpersonid is not null;

GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAScorebyEmployee\sps_rpt_QAScorebyEmployee.sql'
GO
 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAScorebyEmployee')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAScorebyEmployee'
		DROP  Procedure  sps_rpt_QAScorebyEmployee
	END

GO

PRINT 'Creating Procedure sps_rpt_QAScorebyEmployee'
GO
 
 CREATE Procedure sps_rpt_QAScorebyEmployee
	
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
coalesce(el.QAErrorLogDateTime, t.QATrackingReferralDateTime) AS CallDateTime, 
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
			t.QATrackingID

			    
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
	AND coalesce(t.QATrackingReferralDateTime, el.QAErrorLogDateTime) BETWEEN coalesce(@CallStartDateTime, @ErrorStartDateTime,'01/01/1901') AND coalesce(@CallEndDateTime, @ErrorEndDateTime, '12/31/2100')
	AND el.qaerrorlogpersonid is not null
	AND QAMonitoringFormCalculateScore = 1;


GO


