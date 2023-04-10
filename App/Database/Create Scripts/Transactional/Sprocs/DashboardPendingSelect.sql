IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingSelect';
		DROP Procedure DashboardPendingSelect;
	END
GO
PRINT 'Creating Procedure DashboardPendingSelect';
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
CREATE PROCEDURE DashboardPendingSelect
	--Add the parameters for the stored procedure here
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2),
	@OrgName Varchar(50)

AS
/******************************************************************************
**	File: DashboardPendingSelect.sql
**	Name: DashboardPendingSelect
**	Desc: List pending events
**	Auth: jth
**	Date: Sept. 2010
**	Called By: Dashboard
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:		Description:
**	--------		--------	----------------------------------
	09/10			jth			initial
	09/11			jth			added Declared CTOD Pending
**  10/03/2011		ccarroll	Fixed issue with CTOD Pending
**  10/07/2011		ccarroll	Added @CanOpenPopUp HS 29496 wi 13748
**	01/10/12		bjk			Reorganization Call, Message, Referral. Creaeted
**								variable currentDateTime, seperated WebSourceCode into variableTable
**	07/16/2014		ccarroll	Added Organ Med RO Pending CCRST175
*******************************************************************************/
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

DECLARE @TZ int,
		@triageEnabled int,
		@acknowledgeevalexpireminutes int,
		@expirationminutes int,
		@overexpirationminutes int,
		@LeaseOrg1 int = null,
		@currentDateTime datetime = getdate(),
		@STATLINEORGANIZATIONID int = 194,
		@CanOpenPopUp int = 0,
		@DisplayCallOutPending bit = 0,
		@DisplayCTODPending bit = 0,
		@DisplayMedROPending bit = 0;
----------------------------------------------------------------

-- Display Settings
SELECT
	@CanOpenPopUp			= OpenPopUp,
	@DisplayCallOutPending	= DisplayCallOut,
	@DisplayCTODPending		= DisplayCTOD,
	@DisplayMedROPending	= DisplayMedRO
FROM
(
	SELECT DISTINCT
		IsNULL(MAX(CASE DashBoardDisplaySettingId WHEN 1 THEN 1 ELSE 0 END), 0) AS OpenPopUp,
		IsNULL(MAX(CASE DashBoardDisplaySettingId WHEN 2 THEN 1 ELSE 0 END), 0) AS DisplayCallOut,
		IsNULL(MAX(CASE DashBoardDisplaySettingId WHEN 3 THEN 1 ELSE 0 END), 0) AS DisplayCTOD,
		IsNULL(MAX(CASE DashBoardDisplaySettingId WHEN 4 THEN 1 ELSE 0 END), 0) AS DisplayMedRO
	FROM OrganizationDisplaySetting
	WHERE OrganizationId = @LeaseOrg
) tbl;
----------------

IF(@LeaseOrg <> @STATLINEORGANIZATIONID) BEGIN
	SET @LeaseOrg1 = @LeaseOrg
	SET @triageEnabled = -1;
END
ELSE BEGIN
	SET @triageEnabled = 0;
END
--------------------------------

--select these once for the org
SELECT
	@ExpirationMinutes				= ExpirationMinutes,
	@OverExpirationMinutes			= OverExpirationMinutes,
	@AcknowledgeEvalExpireMinutes	= AcknowlegeExpirationMinutes
FROM
(
	SELECT
		MAX(CASE DashBoardTimerTypeID WHEN 1 THEN ExpirationMinutes END) AS ExpirationMinutes,
		MAX(CASE DashBoardTimerTypeID WHEN 2 THEN ExpirationMinutes END) AS OverExpirationMinutes,
		MAX(CASE DashBoardTimerTypeID WHEN 6 THEN ExpirationMinutes END) AS AcknowlegeExpirationMinutes
	FROM OrganizationDashBoardTimer
	WHERE
		DashBoardWindowId = 2
	AND OrganizationID = @LeaseOrg
) tbl;
----------------------------------------------------------------

-- check for the temp tables and drop them if they exist
DROP TABLE IF EXISTS #sourceCodeList;
DROP TABLE IF EXISTS #TempFSCase;
--------------------------------

-- Populate temp tables
SELECT DISTINCT WebReportGroupSourceCode.SourceCodeID
INTO #sourceCodeList
FROM WebReportGroup
	JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
WHERE WebReportGroup.OrgHierarchyParentID = @LeaseOrg;
----------------

SELECT DISTINCT FSCase.CallId
INTO #TempFSCase
FROM FSCase
	JOIN LogEvent ON FSCase.CallId = LogEvent.CallId
	JOIN StatEmployee on LogEvent.LastStatEmployeeID = StatEmployee.StatEmployeeID
	JOIN Person ON StatEmployee.PersonID = Person.PersonID
WHERE FSCaseOpenUserId <> 0
	AND FSCaseFinalUserId = 0
	AND Person.OrganizationID = @LeaseOrg;
----------------------------------------------------------------

IF(@LeaseOrg <> @STATLINEORGANIZATIONID) BEGIN
	SELECT DISTINCT
		Call.CallID,	
		CAST(LogEventDateTime AS TIME(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		Person.PersonFirst + ' ' + SUBSTRING(Person.PersonLast,1,1) CreatedBy,
		''AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LogEventDateTime,
		CASE
			WHEN Call.CallTypeID = 1 THEN COALESCE(CurrentReferralType.ReferralAbbreviation, ReferralType.ReferralAbbreviation, 'UNK' )
			WHEN Call.CallTypeID = 6 THEN 'OAS'
			ELSE 'UNK' 
		END AS CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		(
			SELECT 
				CASE 
					WHEN EXISTS (SELECT [OrganizationPageInterval]
							FROM [Organization]
							WHERE OrganizationID = logevent.organizationid
								and OrganizationPageInterval <> 0) 
					THEN organizationpageinterval
					ELSE @overexpirationminutes	-- Original select was the same as the calc for @overexpirationminutes
				END 
			FROM organization
				--if the orgid is -1 or 0 then use statline default interval 
			WHERE OrganizationID = 
					CASE logevent.organizationid
						WHEN -1 THEN @STATLINEORGANIZATIONID
						WHEN  0 THEN @STATLINEORGANIZATIONID
						ELSE logevent.organizationid
					END
		) AS interval,
		CASE LogEvent.LogEventOrg
			WHEN 'DonorNet' THEN 0
			ELSE 1
		END as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		Q.PersonFirst + ' ' + SUBSTRING(Q.PersonLast,1,1)AS InQueue,
		@CanOpenPopUp AS CanOpenPopUp,
		LogEvent.LogEventID
	FROM Call
		JOIN Referral  ON Call.CallID = Referral.CallID
		JOIN LogEvent ON Call.CallID = LogEvent.CallID
		JOIN #sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
		LEFT JOIN logeventlock ON LogEventLock.LogEventID = LogEvent.LogEventID
		LEFT JOIN StatEmployee emp ON LogEventLock.StatEmployeeID = emp.StatEmployeeID
		LEFT JOIN Person Q ON emp.PersonID = Q.PersonID
		LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
		LEFT JOIN ReferralType ON Referral.ReferralTypeId = ReferralType.ReferralTypeID
		LEFT JOIN referraltype CurrentReferralType on Referral.CurrentReferralTypeId = CurrentReferralType.referralTypeId
		LEFT JOIN #TempFSCase fsc ON Call.CallID = fsc.CallId
	WHERE
		LogEvent.LogEventCallbackPending = -1
	AND	(
				LogEvent.LogEventTypeID = 18 --Fax Pending
			OR	LogEvent.LogEventTypeID = 40 --Labs Pending
			OR	LogEvent.LogEventTypeID = 43 --Online Review Pending
			OR	LogEvent.LogEventTypeID = 55 --Pending E-Referral
			OR	(--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
					LogEvent.LogEventTypeID = 39 --Acknowledge to Evaluate
				AND @DisplayCallOutPending = 1
				AND DateDiff(n, LogEvent.LogEventDateTime, @currentDateTime) > @acknowledgeevalexpireminutes
				)
			OR	(
					fsc.CallID IS NULL --not a Family Services call
				AND	(
						LogEvent.LogEventTypeID = 6  --Page Pending
					OR	LogEvent.LogEventTypeID = 21 --Email Pending
					OR	(--Callout Pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
							LogEvent.LogEventTypeID = 14 --Callout Pending
						AND @DisplayCallOutPending = 1
						AND @currentDateTime > LogEventCalloutDateTime
						)
					)
				)
		)	
UNION ALL	
	SELECT DISTINCT	
		Call.CallID,
		CAST(LogEventDateTime AS TIME(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		Person.PersonFirst + ' ' + SUBSTRING(Person.PersonLast,1,1) CreatedBy,
		'MESSAGE'AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LastModified,
		CASE
			WHEN (Call.calltypeid = 2) THEN 'M' 
			WHEN (Call.calltypeid = 4) THEN 'I' 
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		(
			SELECT --if you have a legit org id and its not null or 0 use that interval, else use statline
				CASE 
					WHEN (
							SELECT TOP 1 [OrganizationPageInterval]
							FROM [Organization]
							WHERE OrganizationID = logevent.organizationid and OrganizationPageInterval <> 0
						) <> 0
					THEN organizationpageinterval
					ELSE (
							SELECT TOP 1 [expirationminutes]
							FROM OrganizationDashBoardTimer
							where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg 
						)  
				END 
				FROM organization
					--if the orgid is -1 or 0 then use statline default interval 
				WHERE OrganizationID = 
					CASE logevent.organizationid
						WHEN -1 THEN @STATLINEORGANIZATIONID
						WHEN  0	THEN @STATLINEORGANIZATIONID
						ELSE logevent.organizationid
					END
		) AS interval,
		CASE
			WHEN(LogEvent.LogEventOrg = 'DonorNet') THEN 0
			ELSE 1
		END AS DONORNETSORT,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		Q.PersonFirst + ' ' + SUBSTRING(Q.PersonLast,1,1)AS InQueue,
		@CanOpenPopUp AS CanOpenPopUp,
		LogEvent.LogEventID
	FROM Call
		JOIN Message ON Call.CallID = Message.CallID 
		JOIN LogEvent ON Call.CallID = LogEvent.CallID
		JOIN #sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
		LEFT JOIN logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
		LEFT JOIN StatEmployee emp ON LogEventLock.StatEmployeeID = emp.StatEmployeeID
		LEFT JOIN Person Q ON emp.PersonID = Q.PersonID
		LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
		LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	WHERE 	
		LogEvent.LogEventCallbackPending = -1
	AND	(
			LogEvent.LogEventTypeID = 6	 --Page Pending
		OR	LogEvent.LogEventTypeID = 18 --Fax Pendiing
		OR	LogEvent.LogEventTypeID = 21 --Email Pending
		OR	LogEvent.LogEventTypeID = 40 --Labs Pending
		OR	LogEvent.LogEventTypeID = 43 --Online Review Pendiing
		OR	LogEvent.LogEventTypeID = 55 --Pending E-Referral
		OR	(--Callout Pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
				LogEvent.LogEventTypeID = 14 --callout pending
			AND @currentDateTime > LogEventCalloutDateTime
			AND	@DisplayCallOutPending = 1
			)
		OR	(--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
				LogEvent.LogEventTypeID = 39 --Acknowledge to Evaluate
			AND DateDiff(n, LogEvent.LogEventDateTime, @currentDateTime) > @acknowledgeevalexpireminutes
			AND @DisplayCallOutPending = 1
			)
		OR	(--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid 
				LogEvent.LogEventTypeID = 45 --Declared CTOD Pending
			AND @DisplayCTODPending = 1
			)
		)
ORDER BY
	donornetsort,
	LogEvent.LogEventDateTime ;
END
IF(@LeaseOrg=194 )
	BEGIN
     SELECT DISTINCT
		Call.CallID,	
		CAST(LogEventDateTime AS TIME(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		Person.PersonFirst + ' ' + SUBSTRING(Person.PersonLast,1,1) CreatedBy,
		''AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LogEventDateTime,
		CASE
			WHEN Call.CallTypeID = 1 THEN COALESCE(CurrentReferralType.ReferralAbbreviation, ReferralType.ReferralAbbreviation, 'UNK' )
			WHEN Call.CallTypeID = 6 THEN 'OAS'
			ELSE 'UNK' 
		END AS CallType,		
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		(
			SELECT 
				CASE 
					WHEN (
							SELECT TOP 1 [OrganizationPageInterval]
							FROM [Organization]
							WHERE OrganizationID = logevent.organizationid
							AND OrganizationPageInterval <> 0
						) <> 0
					THEN OrganizationPageInterval
					ELSE (
							SELECT TOP 1 [expirationminutes]
							FROM OrganizationDashBoardTimer
							WHERE DashBoardWindowId=2
							AND DashBoardTimerTypeID = 2
							AND OrganizationID = @LeaseOrg
						) 
				END 
			FROM organization --if the orgid is -1 or 0 then use statline default interval 
			WHERE OrganizationID = 
				CASE logevent.organizationid
					WHEN -1 THEN @STATLINEORGANIZATIONID
					WHEN  0 THEN @STATLINEORGANIZATIONID
					ELSE logevent.organizationid
				END
		) AS interval,
		CASE
			WHEN(LogEvent.LogEventOrg = 'DonorNet') THEN 0
			ELSE 1
		END AS donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		Q.PersonFirst + ' ' + SUBSTRING(Q.PersonLast,1,1)AS InQueue,
		@CanOpenPopUp AS CanOpenPopUp,
		LogEvent.LogEventID
	FROM Call
		JOIN Referral ON Call.CallID = Referral.CallID
		JOIN LogEvent ON Call.CallID = LogEvent.CallID
		JOIN #sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
		LEFT JOIN logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
		LEFT JOIN StatEmployee emp ON LogEventLock.StatEmployeeID = emp.StatEmployeeID
		LEFT JOIN Person Q ON emp.PersonID = Q.PersonID
		LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
		LEFT JOIN ReferralType ON Referral.ReferralTypeID = ReferralType.ReferralTypeID
		LEFT JOIN referraltype CurrentReferralType on Referral.CurrentReferralTypeId = CurrentReferralType.referralTypeId
		LEFT JOIN #TempFSCase fsc ON Call.CallID = fsc.CallId AND Organization.OrganizationID <> @LeaseOrg
	WHERE 	
		LogEvent.LogEventCallbackPending = -1
	AND	Organization.OrganizationLOTriageEnabled = @triageEnabled
	AND	(
			LogEvent.LogEventTypeID = 18 --Fax Pending
		OR	LogEvent.LogEventTypeID = 40 --Labs Pending
		OR	LogEvent.LogEventTypeID = 43 --Online Review Pending
		OR	LogEvent.LogEventTypeID = 55 --Pending E-Referral
		OR	(
				fsc.CallID IS NULL --not a Statline or MTF Family Services call
			AND	(
					LogEvent.LogEventTypeID = 6  --Page Pending
				OR	LogEvent.LogEventTypeID = 21 --Email Pending
				OR	(--Callout Pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
						LogEvent.LogEventTypeID = 14 --Callout Pending
					AND @DisplayCallOutPending = 1
					AND @currentDateTime > LogEventCalloutDateTime
					)
				)
			)
		OR	(--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
				LogEvent.LogEventTypeID = 39 --Acknowledge to Evaluate
			AND @DisplayCallOutPending = 1
			AND DateDiff(n, LogEvent.LogEventDateTime, @currentDateTime) > @acknowledgeevalexpireminutes
			)
		OR	(--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid 
				LogEvent.LogEventTypeID = 45 --Declared CTOD Pending 
			AND	@DisplayCTODPending = 1
			)
		OR	(--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid 
				LogEvent.LogEventTypeID = 48 --Organ Med RO Pending 
			AND @DisplayMedROPending = 1
			)
		)
UNION ALL
	SELECT DISTINCT	
		Call.CallID,
		CAST(LogEventDateTime AS TIME(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		Person.PersonFirst + ' ' + SUBSTRING(Person.PersonLast,1,1) CreatedBy,
		'MESSAGE'AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LastModified AS LogEventDateTime,
		CASE 
			WHEN (Call.calltypeid = 2) THEN 'M' 
			WHEN (Call.calltypeid = 4) THEN 'I' 
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		(
			SELECT --if you have a legit org id and its not null or 0 use that interval, else use statline
				CASE 
					WHEN (
							SELECT TOP 1 [OrganizationPageInterval]
							FROM [Organization]
							WHERE OrganizationID = logevent.organizationid
							AND OrganizationPageInterval <> 0
						) <> 0
					THEN organizationpageinterval
					ELSE (
							SELECT TOP 1 [expirationminutes]
							FROM OrganizationDashBoardTimer
							WHERE DashBoardWindowId=2
							AND DashBoardTimerTypeID = 2
							AND OrganizationID = @LeaseOrg
						)
				END 
			FROM organization --if the orgid is -1 or 0 then use statline default interval 
			WHERE OrganizationID = 
					CASE logevent.organizationid
						WHEN -1 THEN @STATLINEORGANIZATIONID
						WHEN  0 THEN @STATLINEORGANIZATIONID
						ELSE logevent.organizationid
					END
		) AS interval,
		CASE
			WHEN(LogEvent.LogEventOrg = 'DonorNet') THEN 0
			ELSE 1
		END as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		Q.PersonFirst + ' ' + SUBSTRING(Q.PersonLast,1,1)AS InQueue,
		@CanOpenPopUp AS CanOpenPopUp,
		LogEvent.LogEventID
	FROM Call
		JOIN Message ON Call.CallID = Message.CallID 
		JOIN LogEvent ON Call.CallID = LogEvent.CallID
		JOIN #sourceCodeList scl ON Call.SourceCodeID = scl.SourceCodeID
		LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
		LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
		LEFT JOIN logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
		LEFT JOIN StatEmployee emp ON LogEventLock.StatEmployeeID = emp.StatEmployeeID
		LEFT JOIN Person Q ON emp.PersonID = Q.PersonID
		LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
		LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	WHERE 	
		LogEvent.LogEventCallbackPending=-1
	AND	Organization.OrganizationLOTriageEnabled = @triageEnabled
	AND	(
			LogEvent.LogEventTypeID = 6  --Page Pending
		OR	LogEvent.LogEventTypeID = 18 --Fax Pendiing
		OR	LogEvent.LogEventTypeID = 21 --Email Pending
		OR	LogEvent.LogEventTypeID = 40 --Labs Pending
		OR	LogEvent.LogEventTypeID = 43 --Online Review Pendiing
		OR	LogEvent.LogEventTypeID = 55 --Pending E-Referral
		OR	(--Callout Pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
				LogEvent.LogEventTypeID = 14 --Callout Pending
			AND @DisplayCallOutPending = 1
			AND @currentDateTime > LogEventCalloutDateTime
			)
		OR	(--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
				LogEvent.LogEventTypeID = 39 --Acknowledge to Evaluate
			AND @DisplayCallOutPending = 1
			AND DateDiff(n, LogEvent.LogEventDateTime, @currentDateTime) > @acknowledgeevalexpireminutes
			)
		OR	(--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid
				LogEvent.LogEventTypeID = 45 --Declared CTOD Pending
			AND @DisplayCTODPending = 1
			)
		OR	(--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid
				LogEvent.LogEventTypeID = 48 --Organ Med RO Pending
			AND @DisplayMedROPending = 1
			)
		)
	ORDER BY
		donornetsort,
		LogEventDateTime;
END

-- check for the temp tables and drop if exists
DROP TABLE IF EXISTS #sourceCodeList;
DROP TABLE IF EXISTS #TempFSCase;

GO