PRINT '----------------------------------- Update Database: ' + DB_NAME()  + ' -----------------------------------'
-- -- -- File Manifest Created On:6/15/2012 2:31:14 PM-- -- --  
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Table/DataLoad/QALogos.sql
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Table/DataLoad/QATrackingType.sql
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Transactional/Sprocs/GetReferralInfo.sql
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Transactional/Sprocs/InsertTrackingForm.sql
-- D:\Statline\StatTrac\App\Dev/Database/Create Scripts/Transactional/Sprocs/InsertTrackingNumber.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/QA.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/sps_rpt_QAErrorLog_Select.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QA/sps_rpt_QATrackingForm_Select.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAApproved/QAApproved.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyCAPA/sps_rpt_QAbyCAPA.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyError/sps_rpt_QAbyError.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAbyTrackingNumber/sps_rpt_QAbyTrackingNumber.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAFormsCompletedBy/sps_rpt_QAFormsCompletedBy.sql
-- D:\Statline\StatTrac\Serv\Dev\StatTrac/Data/Database/CreateScripts/Reports/QAUpdate/QAScorebyEmployee/sps_rpt_QAScorebyEmployee.sql


PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Table\DataLoad\QALogos.sql'
GO
/***************************************************************************************************
**	Name: QALogos Type
**	Desc: Data Load for table QALogos
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	10/2011		jth				Initial 
**	06/15/2012	ccarroll		Correct Logo image for MTF
***************************************************************************************************/

/* Update MTF to correct Logo*/
DECLARE @LogoName AS nvarchar(50) = 'MTF'
DECLARE @ImageName AS nvarchar(50) = 'mtf.jpg'
 
IF EXISTS (SELECT TOP 1 * FROM QALogos WHERE LogoName = @LogoName )
BEGIN
	PRINT 'Updating QA Logo: ' + @ImageName +' for ' + @LogoName 
	UPDATE QALogos SET ImageName = @ImageName 
	WHERE LogoName = @LogoName
END
GO
PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Table\DataLoad\QATrackingType.sql'
GO
/***************************************************************************************************
**	Name: QATraining Type
**	Desc: Data Load for table QATrackingType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author		Description
**	----------	------------	--------------------------------------------------------------------
**	10/2011		jth				Initial 
**	06/15/2012	ccarroll		Add Tracking Type and Logo for IIAM  		
***************************************************************************************************/

/* Add QA Tracking Type: IIAM
	Adding a QA Tracking Type requires adding data to the following tables:
	1. QALogo
	2. QA TrackingType 

	Declare QA Tracking Type to be added:
*/

DECLARE @QATrackingTypeDescription AS varchar(255) = 'IIAM',
		@QATrackingTypeImageName AS varchar(50) = 'statline.jpg',
		@QATrackingTypeId AS Int,
		@OrganizationID AS Int = 194, -- Statline
		@LastStatEmployeeId AS Int = 1100,
		@AuditLogTypeId AS Int = 1 -- Create

IF NOT EXISTS (SELECT TOP 1 QATrackingTypeId FROM QATrackingType WHERE QATrackingTypeDescription = @QATrackingTypeDescription )
BEGIN

/* Insert QA Tracking Type */
PRINT 'Adding Tracking Type: ' + @QATrackingTypeDescription
INSERT dbo.QATrackingType (
	OrganizationID,
	QATrackingTypeDescription,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
	) VALUES (
	@OrganizationID, --OrganizationID
	@QATrackingTypeDescription,
	GETDATE(), -- LastModified
	@LastStatEmployeeId,
	@AuditLogTypeId
	)

SET @QATrackingTypeId = @@IDENTITY

/* Insert QA Logo */
PRINT 'Adding Tracking Type Logo: ' + @QATrackingTypeImageName + ' - ' + @QATrackingTypeDescription
INSERT dbo.QALogos (
	LogoName,
	OrganizationID,
	TrackingTypeID,
	ImageName
	) VALUES (
	@QATrackingTypeDescription, --LogoName
	@OrganizationID, --OrganizationID
	@QATrackingTypeId, --TrackingTypeID,
	@QATrackingTypeImageName --ImageName
	)

END
GO
PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Transactional\Sprocs\GetReferralInfo.sql'
GO
IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id (N'[dbo].[GetReferralInfo]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1) 
BEGIN
	DROP PROCEDURE [dbo].[GetReferralInfo]
	PRINT 'Dropping Procedure: GetReferralInfo'
END
	PRINT 'Creating Procedure: GetReferralInfo'
GO

CREATE PROCEDURE [dbo].[GetReferralInfo]
(
	@CallID int = NULL,
	@WebReportGroupID int = null
)
/******************************************************************************
**		File: GetReferralInfo.sql
**		Name: GetReferralInfo
**		Desc:  Used on QA Update Tab, Web UI
**
**		Called by:  
**              
**
**		Auth: jth
**		Date: 03/2009
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:		Description:
**		--------	--------	-------------------------------------------
**		03/2009		jth			initial
**	   04/2010		bret			updating to include in release
**      04/10       jth          if report group id is 37, accept all
**	   04/16/2012	ccarroll	Fixed issue not returning Message/Import Call Types
*******************************************************************************/
AS

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
	SET NOCOUNT ON 
	 

	SELECT	Call.CallDateTime,
			SourceCode.SourceCodeName,
			Call.CallID,
			CallType.CallTypeName,
            ISNULL(MessageType.MessageTypeID, Referral.ReferralTypeID) AS ReferralTypeID1,
			ISNULL(MessageType.MessageTypeName, ReferralType.ReferralTypeName) AS ReferralTypeName
	FROM        
			Call
			JOIN CallType ON CallType.CallTypeID = Call.CallTypeID
			JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID
			LEFT JOIN Referral ON Referral.CallID = Call.CallID
			LEFT JOIN ReferralType ON Referral.ReferralTypeID =  ReferralType.ReferralTypeID
			LEFT JOIN [Message] ON [Message].CallID = Call.CallID
			LEFT JOIN MessageType ON [Message].MessageTypeID = MessageType.MessageTypeID				 
	WHERE 
		Call.CallID = @CallID 

	RETURN @@Error
GO


  
GO
PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Transactional\Sprocs\InsertTrackingForm.sql'
GO
--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertTrackingForm')
	BEGIN
		PRINT 'Dropping Procedure InsertTrackingForm'
		DROP  Procedure  InsertTrackingForm
	END

GO

PRINT 'Creating Procedure InsertTrackingForm'
GO

CREATE PROCEDURE InsertTrackingForm
@EmpID int,
@PersonID int,
@returnVal int OUTPUT

AS
/******************************************************************************
**	File: InsertTrackingForm.sql
**	Name: InsertTrackingForm
**	Desc: Inserts a tracking form into the qa system
**	Auth: jim hawkins
**	Date: 2009
**	Called By: QA Module
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
** 04/27/2012		ccarroll				Added missing column values on insert.
*******************************************************************************/

BEGIN
--Insert the values
INSERT INTO QATrackingForm
(
	QAProcessStepID,
	PersonID,
	QATrackingEventDateTime,
	QATrackingCAPANumber,
	QATrackingApproved,
	QATrackingStatusID,
	QATrackingFormPoints,
	QATrackingFormComments,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
) VALUES 
(
	1,			-- QAProcessStepID
	@PersonID,	-- PersonID
	getdate(),	-- QATrackingEventDateTime
	null,		-- QATrackingCAPANumber
	0,			-- QATrackingApproved
	null,		-- QATrackingStatusID
	0,			-- QATrackingFormPoints
	null,		-- QATrackingFormComments
	getdate(),	-- LastModified
	@EmpID,		-- LastStatEmployeeID
	1			-- AuditLogTypeID
)


--Select the column to send back
SELECT @returnVal = MAX(QATrackingFormID) FROM QATrackingForm

--Return Value
RETURN @returnVal

END

GO


GO
PRINT 'D:\Statline\StatTrac\App\Dev\Database\Create Scripts\Transactional\Sprocs\InsertTrackingNumber.sql'
GO
--Procedure to insert values into table and return last value
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'InsertTrackingNumber')
	BEGIN
		PRINT 'Dropping Procedure InsertTrackingNumber'
		DROP  Procedure  InsertTrackingNumber
	END

GO

PRINT 'Creating Procedure InsertTrackingNumber'
GO
/******************************************************************************
**	File: InsertTrackingNumber.sql
**	Name: InsertTrackingNumber
**	Desc: Inserts a tracking number into the qa system, along with the tracking type and some other data
**	Auth: jim hawkins
**	Date: 2009
**	Called By: When user adds a qa tracking number to a form or error
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*** 9/10            jth                     added parm and code to use various tracking types other than StatTrac
** 04/27/2012		ccarroll				Added missing column values on insert.
 *******************************************************************************/
CREATE PROCEDURE InsertTrackingNumber
@QAOrgID int,
@QATrackingNumber varchar(20),
@EmpID int,
@SourceCode varchar(20),
@RefDateTime datetime,
@RefTypeID int,
@FromQAForm int,
@QAFormID int,
@returnVal int OUTPUT

AS


BEGIN
--Insert the values
DECLARE @TrackingTypeID int

if @FromQAForm = 1
Begin
	select @TrackingTypeID=QATrackingTypeID FROM QAMonitoringForm where qamonitoringformid = @QAFormID 
End
Else
Begin
	set @TrackingTypeID=@QAFormID
end
INSERT INTO QATracking
(
	OrganizationID,
	QATrackingTypeID,
	QATrackingNumber,
	QATrackingNotes,
	QATrackingSourceCode,
	QATrackingReferralDateTime,
	QATrackingReferralTypeID,
	QATrackingStatusID,
	LastModified,
	LastStatEmployeeID,
	AuditLogTypeID
)  VALUES (
	@QAOrgID, 
	@TrackingTypeID, 
	@QATrackingNumber,
	null,
	@SourceCode,
	@RefDateTime,
	@RefTypeID,
	1,
	getdate(),
	@EmpID,
	1
)



--Select the column to send back


SELECT @returnVal = MAX(QATrackingID) FROM QATracking



--Return Value


RETURN @returnVal


END

GO


PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QA\QA.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QA'
		DROP  Procedure  sps_rpt_QA
	END

GO

PRINT 'Creating Procedure sps_rpt_QA'
GO


CREATE Procedure [dbo].[sps_rpt_QA]
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

AS
/******************************************************************************
**		File: sps_rpt_QA.sql
**		Name: sps_rpt_QA.sql
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
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth					Initial release
**		08/14/2009		ccarroll			Created temp table. split sproc into two locations,
**											one for TrackingForm and one for Error Log.
**											Added WHERE to only show errors.
**		5/2010			Sue Dabiri			Added QAMonitoring Form Name Field
**		06/02/2010		James Gerberich		Removed QATrackingEventDateTime field and added Distinct to 
**											final select statement to avoid dups in report.  HS 23872
**		09/27/2010		jegerberich			Added @TrackingTypeID variable and WHERE logic to 
**											accomodate the parameter in filtering results. HS 25264
**      10/2011         jth					fixed table variable for errmonth, erryear, refmonnum and refyear to be varchar
**		04/13/2012		ccarroll			Added required fields for link to QAReview Report
*******************************************************************************/

--declare @ErrorLocationID			int 
--declare	@ProcessStepID				int 
--declare	@ErrorTypeID				int 
--declare	@HowIdentifiedID			int 
--declare	@ZeroErrors					int 
--declare	@Personids	 				varchar(8000) 
--declare	@CallStartDateTime		    DateTime 
--declare	@CallEndDateTime		    DateTime 
--declare	@ErrorStartDateTime		    DateTime 
--declare	@ErrorEndDateTime			DateTime 
--declare	@TrackingTypeID				int 
--declare	@ReportGroupID				int 
--declare	@OrganizationID				int 
--declare	@SourceCodeName				varchar(10) 
--declare	@DisplayMT					int 


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON
 
IF  @ZeroErrors = 0
	BEGIN
		SET @ZeroErrors	= Null
	END
ELSE
	BEGIN
		SET @ZeroErrors	= 0
	END
	
CREATE TABLE #Temp_QA
   (
		[SourceCode] [varchar] (15) NULL,
		[CallDateTime] [Datetime] Null,
		[QATrackingNumber] [varchar] (20) Null,
		[QAMonitoringFormName] [varchar] (255) Null,
		[QAErrorLogNumberOfErrors] [int] Null,
		[QAErrorLogComments] [varchar] (1000)Null,
		[HowIdentified] [varchar] (250)Null,
		[Employee] [varchar] (101)Null,
		[EmployeeFirst] [varchar] (50)Null,
		[EmployeeLast] [varchar] (50)Null,
		[RefMonthNum] [varchar] (20) Null,
		[RefMonth] [varchar] (20) Null,
		[RefYear] [varchar] (20) Null,
		[ErrMonthNum] [varchar] (20) Null,
		[ErrMonth] [varchar] (20) Null,
		[ErrYear] [varchar] (20) Null,
		[ProcessStep] [varchar] (255) Null,
		[ErrorType] [varchar] (255) Null,
		[ErrorLocation] [varchar] (255)Null,
		[QATrackingTypeDescription] [varchar](255) NULL,
		[EmployeeFullName] [varchar] (255) NULL,
		[PersonID] [int] Null,
		[QAMonitoringFormID] [int] Null,
		[QATrackingFormID] [int] Null,
		[New] [int] Null,
		[CompletedBy] [varchar] (255) Null,
		[QATrackingID] [int] Null,
		)
   
TRUNCATE TABLE #Temp_QA

	INSERT #Temp_QA
		exec sps_rpt_QATrackingForm_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@TrackingTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT

	INSERT #Temp_QA
		exec sps_rpt_QAErrorLog_Select
				@ErrorLocationID,
				@ProcessStepID,
				@ErrorTypeID,
				@TrackingTypeID,
				@HowIdentifiedID,
				@ZeroErrors,
				@Personids,
				@CallStartDateTime,
				@CallEndDateTime,
				@ErrorStartDateTime,
				@ErrorEndDateTime,
				@ReportGroupID,
				@OrganizationID,
				@SourceCodeName,
				@DisplayMT
				
				
SELECT DISTINCT * FROM #Temp_QA
WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
ORDER BY
QATrackingNumber,
EmployeeLast,
ErrorLocation




GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QA\sps_rpt_QAErrorLog_Select.sql'
GO
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
	QATrackingType.QATrackingTypeDescription,
	ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
	QATrackingForm.PersonID,
	QAMonitoringForm.QAMonitoringFormID,
	QATrackingForm.QATrackingFormID,
	CASE WHEN IsNull(QATracking.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
	ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS CompletedBy,
	QATracking.QATrackingID



FROM
	QAErrorLog 
	INNER JOIN QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
	Left Join QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
	Left Join QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
                      --QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      --QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
	/* Added joins for URL query string */
	LEFT JOIN dbo.QATrackingType
	ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
	LEFT JOIN dbo.QATrackingFormErrors ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID
	LEFT JOIN dbo.QATrackingForm ON QATrackingForm.QATrackingFormID = dbo.QATrackingFormErrors.QATrackingFormID
	LEFT JOIN dbo.Person
	ON dbo.QATrackingForm.PersonID = Person.PersonID
	LEFT JOIN dbo.Person AS CompletedBy
	ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
    LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
WHERE 
QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND IsNull(QATrackingSourceCode,0) = IsNull(@SourceCodeName,IsNull(QATrackingSourceCode,0))
AND QAErrorLog.QAErrorLocationID = IsNull(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
AND IsNull(QAErrorLogHowIdentifiedid,0) = IsNull(@HowIdentifiedID, IsNull(QAErrorLogHowIdentifiedid,0))
AND QAErrorLog.QAProcessStepID = IsNull(@ProcessStepID, QAErrorLog.QAProcessStepID)
AND QAErrorLog.QAErrorTypeID = IsNull(@ErrorTypeID, QAErrorLog.QAErrorTypeID)
AND qatracking.QATrackingTypeID = IsNull(@TrackingTypeID, qatracking.QATrackingTypeID)	
AND QATrackingReferralDateTime BETWEEN IsNull(@CallStartDateTime, '01/01/1901') AND IsNull(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN IsNull(@ErrorStartDateTime, '01/01/1901') AND IsNull(@ErrorEndDateTime, '12/31/2100')
AND QAErrorLogNumberOfErrors BETWEEN IsNull(@ZeroErrors, 0) AND IsNull(@ZeroErrors, 99999)
--AND QAErrorLog.StatEmployeeID IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(QAErrorLog.QAErrorLogPersonID AS VarChar)+ '%', IsNull(@Personids, CAST(QAErrorLog.QAErrorLogPersonID AS VarChar))) > 0




GO
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QA\sps_rpt_QATrackingForm_Select.sql'
GO
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
	QATracking.QATrackingID

FROM
	QATrackingForm
	INNER JOIN QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID
	INNER JOIN QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID
	INNER JOIN QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID
	INNER JOIN QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
	Left Join QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
	Left Join QAMonitoringForm ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
	LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID

	/* Added joins for URL query string */
	LEFT JOIN dbo.QATrackingType
	ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
	LEFT JOIN dbo.Person
	ON dbo.QATrackingForm.PersonID = Person.PersonID
	LEFT JOIN dbo.Person AS CompletedBy
	ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
                      
WHERE 
QATracking.OrganizationID = IsNull(@OrganizationID, QATracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
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
AND	QATracking.QATrackingTypeID = IsNull(@TrackingTypeID, QATracking.QATrackingTypeID)


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
**		File: sps_rpt_QAApproved.sql
**		Name: sps_rpt_QAApproved.sql
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
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      5/2009			jth			Initial release
**      3/10            jth			added tracking type parm 
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
*******************************************************************************/ 

SELECT DISTINCT (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode, 
                      QATracking.QATrackingReferralDateTime as CallDateTime, QATracking.QATrackingNumber  
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
			LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
WHERE QATrackingApproved=1
AND QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
AND qatracking.QATrackingTypeID = ISNULL(@TrackingTypeID, qatracking.QATrackingTypeID)
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
GO

 
GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAbyCAPA\sps_rpt_QAbyCAPA.sql'
GO
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyCAPA')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyCAPA'
		DROP  Procedure  sps_rpt_QAbyCAPA
	END

GO

PRINT 'Creating Procedure sps_rpt_QAbyCAPA'
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
*******************************************************************************/

IF LEN(@TrackingNum) > 0 OR LEN(@CAPANum) > 0
BEGIN
	SET @CallStartDateTime = Null
	SET @CallEndDateTime = Null
	SET @ErrorStartDateTime = Null
	SET @ErrorEndDateTime = Null
END

SELECT DISTINCT 
                      QATrackingForm.QATrackingFormID,  (case  when len(QATrackingForm.QATrackingCAPANumber) > 0  then QATrackingForm.QATrackingCAPANumber else 'N/A' end) QATrackingCAPANumber, 
	          (case  when len(QATrackingSourceCode) > 0  then QATrackingSourceCode else 'N/A' end)  SourceCode, 
                      QATracking.QATrackingReferralDateTime as CallDateTime, QATracking.QATrackingNumber
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
					LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
                      
WHERE 
QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
and QATrackingCAPANumber = ISNULL(@CAPANum,QATrackingCAPANumber)
AND qatracking.QATrackingTypeID = ISNULL(@TrackingTypeID, qatracking.QATrackingTypeID)
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
and qatrackingcapanumber > '0'
GO

GO
PRINT 'D:\Statline\StatTrac\Serv\Dev\StatTrac\Data\Database\CreateScripts\Reports\QAUpdate\QAbyError\sps_rpt_QAbyError.sql'
GO
  IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'sps_rpt_QAbyError')
	BEGIN
		PRINT 'Dropping Procedure sps_rpt_QAbyError'
		DROP  Procedure  sps_rpt_QAbyError
	END

GO

PRINT 'Creating Procedure sps_rpt_QAbyError'
GO
 
 CREATE Procedure sps_rpt_QAbyError
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

AS
/******************************************************************************
**		File: sps_rpt_QAbyError.sql
**		Name: sps_rpt_QAbyError.sql
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
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		09/18/2009		ccarroll	added WHERE IsNull(QAErrorLogNumberOfErrors,0) > 0
**		10/03/2009		ccarroll	added @ErrorTypeID to WHERE
**      3/10            jth         added tracking type parm
**		05/28/2010		JGerberich	Removed QAErrorLog.QAErrorTypeID replaced 
**									with QAMonitoringFormTemplate.QAErrorTypeID HS #23404
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
*******************************************************************************/ 
IF  @ZeroErrors = 0
BEGIN
	SET @ZeroErrors	= NULL
END
ELSE
BEGIN
	SET @ZeroErrors	= 0
END

SELECT
	QATrackingSourceCode AS SourceCode, 
	CASE
		WHEN
			(QATrackingForm.QATrackingFormID)IS NOT NULL
		THEN
			CASE
				WHEN
					ISNULL(QAErrorLogPointsYes,0) = 1
				AND ISNULL(QAErrorTypeGenerateLogIfYes, 0) = 1
				THEN 1
				WHEN
					ISNULL(QAErrorLogPointsNo, 0) = 1
				AND ISNULL(QAErrorTypeGenerateLogIfNo, 0) = 1
				THEN 1
				ELSE 0
			END
		ELSE
			QAErrorLog.QAErrorLogNumberOfErrors
	END AS QAErrorLogNumberOfErrors,
	QATrackingReferralDateTime AS CallDateTime,
	QATrackingNumber, 
	DatePart(Month,QATrackingReferralDateTime) AS RefMonthNum,
	DateName(Month,QATrackingReferralDateTime) AS RefMonth,
	DateName(Year,QATrackingReferralDateTime) AS RefYear,
	DatePart(Month,QAErrorLogDateTime) AS ErrMonthNum,
	DateName(Month,QAErrorLogDateTime) AS ErrMonth,
	DateName(Year,QAErrorLogDateTime) AS ErrYear,
	CASE
		WHEN
			(QATrackingForm.QAProcessStepID)IS NOT NULL
		THEN
			(
				SELECT
					QAProcessStepDescription
				FROM
					QAProcessStep
				WHERE
					QAProcessStepID = QATrackingForm.QAProcessStepID
			)
		ELSE
			(
				SELECT
					QAProcessStepDescription
				FROM
					QAProcessStep
				WHERE
					QAProcessStepID = QAErrorLog.QAProcessStepID)
	END AS ProcessStep,
	(
		SELECT
			QAErrorTypeDescription
		FROM
			QAErrorType
		WHERE
			QAErrorTypeID = QAErrorLog.QAErrorTypeID
	) AS ErrorType,
	(
		SELECT
			QAErrorLocationDescription
		FROM
			QAErrorLocation
		WHERE
			QAErrorLocationID = QAErrorLog.QAErrorLocationID
	) AS ErrorLocation,
	QATrackingForm.QATrackingEventDateTime
					/*FROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
                      INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID*/
FROM
	QATracking
INNER JOIN QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID
INNER JOIN QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID
LEFT OUTER JOIN QATrackingForm
INNER JOIN QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID
	ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
INNER JOIN QAMonitoringFormTemplate ON QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
WHERE 
	QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
	AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND ISNULL(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,ISNULL(QATrackingSourceCode,0))
AND (
		(
			ISNULL(QAErrorLogPointsYes,0) = 1
		AND ISNULL(QAErrorTypeGenerateLogIfYes, 0) = 1
		)
	OR
		(
			ISNULL(QAErrorLogPointsNo, 0) = 1
		AND ISNULL(QAErrorTypeGenerateLogIfNo, 0) = 1
		)
	OR
		(
			ISNULL(QAErrorLogNumberOfErrors,0) > 0
		)
	)
AND ISNULL(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,ISNULL(QATrackingSourceCode,0))
AND QAErrorLog.QAErrorLocationID = ISNULL(@ErrorLocationID, QAErrorLog.QAErrorLocationID)
--AND QAErrorLog.QAErrorTypeID = ISNULL(@ErrorTypeID ,QAErrorLog.QAErrorTypeID)
AND QAMonitoringFormTemplate.QAErrorTypeID = IsNull(@ErrorTypeID ,QAMonitoringFormTemplate.QAErrorTypeID)
AND QATracking.QATrackingTypeID = ISNULL(@TrackingTypeID, QATracking.QATrackingTypeID)
AND ISNULL(QATrackingForm.QAProcessStepID,QAErrorLog.QAProcessStepID) = ISNULL(@ProcessStepID, ISNULL(QATrackingForm.QAProcessStepID,QAErrorLog.QAProcessStepID))
AND QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
--And QAErrorLogNumberOfErrors BETWEEN ISNULL(@ZeroErrors, 0) AND ISNULL(@ZeroErrors, 99999)
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
	@ReportGroupID				int = Null,
	@OrganizationID				int = Null,
	@SourceCodeName				varchar(10) = Null,
	@DisplayMT					int = Null

AS
/******************************************************************************
**		File: sps_rpt_QAbyTrackingNumber.sql
**		Name: sps_rpt_QAbyTrackingNumber.sql
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
**		Date:			Author:			Description:
**		--------		--------		-------------------------------------------
**      5/2009			jth				Initial release
**		08/018/2009		ccarroll		added CASE statement for error counts
**		09/21/2009		ccarroll		Change WHERE clause to include Tracking Numbers which
**										have errors defined by GenerateLogIfYes and GenerareLogIfNo options.
**		10/03/2009		ccarroll		changed QAErrorLogCorrection to CorrectionLog to match sort option
**		5/10			Sue Dabiri		Added QAMonitoringForm Name field
**		04/19/2012		ccarroll		Added CASE statement for QAMonitoringFormName CCRST143 -wi 1299
**		04/26/2012		ccarroll		Added JOIN to WebReportGroupOrg for ASP users CCRST143
*******************************************************************************/ 

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON

IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   null
	END
			

SELECT DISTINCT 
                      QATrackingForm.QATrackingFormID,  
	         
                      QATracking.QATrackingReferralDateTime,
                      QATracking.QATrackingNumber,
					  CASE WHEN QAMonitoringFormName is null THEN 'N/A' ELSE QAMonitoringFormName END AS QAMonitoringFormName,
CASE WHEN (qatrackingform.qatrackingformid)is not null THEN
			CASE WHEN IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1 THEN 1
				 WHEN IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1 THEN 1
			ELSE 0 END
else
QAErrorLog.QAErrorLogNumberOfErrors
end
AS QAErrorLogNumberOfErrors,
case when (qatrackingform.qatrackingformid)is not null then                      
 (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid)
else
(SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS Employee,
case when (qatrackingform.qatrackingformid)is not null then
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) 
else
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
AS EmployeeFirst,
case when (qatrackingform.qatrackingformid)is not null then
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid)
else
(SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = QAErrorLogPersonID)
end
 AS EmployeeLast,
case when (qatrackingform.qatrackingformid)is not null then
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qatrackingform.qaprocessstepid)
else
(SELECT     qaprocessstepdescription
                            FROM          qaprocessstep
                            WHERE      qaprocessstepid = qaerrorlog.qaprocessstepid)
end
 AS ProcessStep,

                          (SELECT     qaerrortypedescription
                            FROM          qaerrortype
                            WHERE      qaerrortypeid = qaerrorlog.qaerrortypeid) AS Errortype,
                          (SELECT     qaerrorlocationdescription
                            FROM          qaerrorlocation
                            WHERE      qaerrorlocationid = qaerrorlog.qaerrorlocationid) AS ErrorLocation,
                          (SELECT     QAErrorLogHowIdentifiedDescription
                            FROM          QAErrorLogHowIdentified
                            WHERE      QAErrorLogHowIdentifiedid = qaerrorlog.QAErrorLogHowIdentifiedid) AS HowIdentified,
QAErrorLog.QAErrorLogDateTime, QAerrorlog.QAerrorlogComments, QAErrorLog.QAErrorLogTicketNumber,
QAErrorLog.QAErrorLogCorrection AS CorrectionLog
/*Old JoinsFROM         QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID INNER JOIN
                      QAErrorLog ON QATrackingFormErrors.QAErrorLogID = QAErrorLog.QAErrorLogID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID INNER JOIN
                      QATracking ON QAErrorLog.QATrackingID = QATracking.QATrackingID
*/ 
FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID INNER JOIN
                      QAErrorType ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
             Left Join QAMonitoringFormTemplate on QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate.QAMonitoringFormTemplateID
			 Left Join QAMonitoringForm on QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID
             LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
WHERE 
QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
AND QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
AND QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
AND QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
AND (
		(IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1)
	OR	(IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1)
	OR	(IsNull(QAErrorLogNumberOfErrors,0) > 0)
	)
	




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
*******************************************************************************/

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON


IF @TrackingNum is not null
	BEGIN 
		SET @CallStartDateTime	=	Null
		set @CallEndDateTime	=	Null
		set @ErrorStartDateTime	=	Null
		set @ErrorEndDateTime	=   Null
	END


SELECT DISTINCT QATrackingForm.QATrackingFormID,
				QATrackingForm.QATrackingFormPoints,
				QATracking.QATrackingNumber,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS Employee,

				 QAErrorLog.StatEmployeeID,

                          (SELECT     ISNULL(Person.PersonFirst, '') + ' ' + ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = statemployeeid) AS CompletedBy,
				
				QATrackingForm.PersonID,
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
					QATrackingType.QATrackingTypeDescription,
					ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
					QAMonitoringForm.QAMonitoringFormID,
					QAMonitoringForm.QAMonitoringFormName,
					CASE WHEN IsNull(QATracking.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
					ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS QATrackingFormCompletedBy,
					QATracking.QATrackingID

FROM         QATracking INNER JOIN
                      QAErrorLog ON QATracking.QATrackingID = QAErrorLog.QATrackingID LEFT OUTER JOIN
                      QATrackingForm INNER JOIN
                      QATrackingFormErrors ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID ON 
                      QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
					LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
					/* Added joins for URL query string */
					LEFT JOIN dbo.QATrackingType
					ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
					LEFT JOIN dbo.QAMonitoringFormTemplate
					ON dbo.QAMonitoringFormTemplate.QAMonitoringFormTemplateID = QAErrorLog.QAMonitoringFormTemplateID
					LEFT JOIN dbo.QAMonitoringForm
					ON QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID 
					LEFT JOIN dbo.Person
					ON dbo.QATrackingForm.PersonID = Person.PersonID
					LEFT JOIN dbo.Person AS CompletedBy
					ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
WHERE
QATrackingForm.QATrackingFormID Is Not Null
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
AND QATracking.OrganizationID = ISNULL(@OrganizationID, QATracking.OrganizationID) 
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
and QATrackingNumber = ISNULL(@TrackingNum,QATrackingNumber)
AND qatracking.QATrackingTypeID = ISNULL(@TrackingTypeID, qatracking.QATrackingTypeID)	
AND  StatEmployeeID = ISNULL(@CompletedByID, StatEmployeeID)
and QAErrorLog.qaerrorlogpersonid is not null
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')
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
**		Date:			Author:				Description:
**		--------		--------			-------------------------------------------
**      6/2009			jth			Initial release
**		08/17/2009		ccarroll	Added SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
**		10/06/2009		ccarroll	added PATINDEX to @Personids selection in WHERE
**		10/07/2009		ccarroll	removed QAErrorTypeGenerateLogIfYes from WHERE
**      3/10			jth			added tracking type parm  
**		5/10			sdabiri		Added Field QAMonitoring form and changed how the tables
**									are joined.
**      11/10           jth			added qaerrorlogpersonid is not null to where clause
**		04/12/2012		ccarroll	Added required fields for link to QAReview Report
**		04/20/2012		ccarroll	Change order of Employee name to be Last, First to match selection criteria CCRST143 -wi 1300
**		04/26/2012		ccarroll	Added JOIN to WebReportGroupOrg for ASP users CCRST143
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


SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

SET NOCOUNT ON

SELECT DISTINCT 
QATrackingForm.QATrackingFormID, QATrackingSourceCode as SourceCode, QATracking.QATrackingReferralDateTime AS CallDateTime, QATracking.QATrackingNumber,QAMonitoringForm.QAMonitoringFormName, 
QATrackingForm.QATrackingEventDateTime, QATracking.QATrackingReferralTypeID, QATrackingForm.QATrackingFormPoints,
(SELECT     ISNULL(Person.PersonLast, '') + ', ' + ISNULL(Person.PersonFirst, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS Employee,
 (SELECT     ISNULL(Person.PersonFirst, '') 
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeFirst,
 (SELECT     ISNULL(Person.PersonLast, '')
                            FROM          person
                            WHERE      person.personid = qatrackingform.personid) AS EmployeeLast,
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
			QATrackingType.QATrackingTypeDescription,
			ISNULL((Person.PersonFirst + ' '), '') + ISNULL((Person.PersonMI + ' '), '') + ISNULL(Person.PersonLast, '') AS EmployeeFullName,
			QATrackingForm.PersonID,
			QAMonitoringForm.QAMonitoringFormID,
			CASE WHEN IsNull(QATracking.QATrackingNumber, '') = '' THEN 1 ELSE 2 END AS New,
			ISNULL((CompletedBy.PersonFirst + ' '), '') + ISNULL((CompletedBy.PersonMI + ' '), '') + ISNULL(CompletedBy.PersonLast, '') AS CompletedBy,
			QATracking.QATrackingID

			    
			FROM   QATracking
			LEFT JOIN WebReportGroupOrg ON WebReportGroupOrg.OrganizationID = QAtracking.OrganizationID
			INNER JOIN QAErrorLog 
			ON QATracking.QATrackingID = QAErrorLog.QATrackingID
			INNER JOIN QAErrorType
            ON QAErrorLog.QAErrorTypeID = QAErrorType.QAErrorTypeID 
            INNER JOIN QATrackingFormErrors 
            ON QAErrorLog.QAErrorLogID = QATrackingFormErrors.QAErrorLogID
            LEFT OUTER JOIN QATrackingForm
            ON QATrackingForm.QATrackingFormID = QATrackingFormErrors.QATrackingFormID 
            Left join QAMonitoringFormTemplate 
            on QAErrorLog.QAMonitoringFormTemplateID = QAMonitoringFormTemplate .QAMonitoringFormTemplateID
		    left outer Join QAMonitoringForm QAMonitoringForm 
		    on QAMonitoringFormTemplate.QAMonitoringFormID = QAMonitoringForm.QAMonitoringFormID 
            
			/* Added joins for URL query string */
			LEFT JOIN dbo.QATrackingType
            ON dbo.QATrackingType.QATrackingTypeID = QATracking.QATrackingTypeID
			LEFT JOIN dbo.Person
			ON dbo.QATrackingForm.PersonID = Person.PersonID
			LEFT JOIN dbo.Person AS CompletedBy
			ON QAErrorLog.StatEmployeeID = CompletedBy.PersonID
			            

WHERE 
qatracking.OrganizationID = ISNULL(@OrganizationID, qatracking.OrganizationID)
AND WebReportGroupOrg.WebReportGroupID = ISNULL(@ReportGroupID, 0)
and isNull(QATrackingSourceCode,0) = ISNULL(@SourceCodeName,IsNull(QATrackingSourceCode,0))
--and qatrackingform.personid IN(SELECT * FROM dbo.ParseVarcharValueString(@Personids))
AND PATINDEX('%' + CAST(qatrackingform.personid AS varchar)+ '%', IsNull(@Personids, CAST(qatrackingform.personid AS varchar))) > 0
and qaerrorlogpersonid is not null
--AND (
--		(IsNull(QAErrorLogPointsYes,0) = 1 AND IsNull(QAErrorTypeGenerateLogIfYes, 0) = 1)
--	OR	(IsNull(QAErrorLogPointsNo, 0) = 1 AND IsNull(QAErrorTypeGenerateLogIfNo, 0) = 1)
--	OR	(IsNull(QAErrorLogNumberOfErrors,0) > 0)
--	)
AND qatracking.QATrackingTypeID = ISNULL(@TrackingTypeID, qatracking.QATrackingTypeID)	
And QATrackingReferralDateTime BETWEEN ISNULL(@CallStartDateTime, '01/01/1901') AND ISNULL(@CallEndDateTime, '12/31/2100')
And QAErrorLogDateTime BETWEEN ISNULL(@ErrorStartDateTime, '01/01/1901') AND ISNULL(@ErrorEndDateTime, '12/31/2100')


GO


