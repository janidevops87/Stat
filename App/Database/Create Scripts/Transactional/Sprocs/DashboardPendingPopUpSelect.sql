 IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardPendingPopUpSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardPendingPopUpSelect'
		DROP Procedure DashboardPendingPopUpSelect
	END
GO
PRINT 'Creating Procedure DashboardPendingPopUpSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/******************************************************************************
**	File: DashboardPendingPopUpSelect.sql
**	Name: DashboardPendingPopUpSelect
**	Desc: List pending events for pop up
**	Auth: jth
**	Date: June 2011
**	Called By: Pending Events
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:		Description:
**	--------		--------	----------------------------------
	06/11			jth			initial
**  10/03/2011		ccarroll	Added Declared CTOD Pending Event
**	07/16/2014		ccarroll	Added Organ Med RO Pending Event CCRST175
*******************************************************************************/

CREATE PROCEDURE DashboardPendingPopUpSelect
	-- Add the parameters for the stored procedure here
	@LeaseOrg INT =0,
	@vTZ	VARCHAR(2),
	@OrgName Varchar(80)
AS
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 
    DECLARE @TZ int,
			@triageEnabled int,
			@acknowledgeevalexpireminutes int,
			@expirationminutes int,
			@overexpirationminutes int,          
			@LeaseOrg1 int = null   
	IF(@LeaseOrg<>194 )
	BEGIN
		SET @LeaseOrg1 = @LeaseOrg
		set @triageEnabled = -1
	END
	Else
	BEGIN
		set @triageEnabled = 0
	END
--select these once for the org
SELECT TOP 1 @expirationminutes = [expirationminutes]  FROM OrganizationDashBoardTimer where DashBoardWindowId=2 and DashBoardTimerTypeID = 1 and OrganizationID = @LeaseOrg 
SELECT TOP 1 @overexpirationminutes = [expirationminutes] FROM OrganizationDashBoardTimer  where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg 
SELECT TOP 1 @acknowledgeevalexpireminutes = [expirationminutes] FROM OrganizationDashBoardTimer where DashBoardWindowId=2 and DashBoardTimerTypeID = 6 and OrganizationID = @LeaseOrg 
EXEC spf_TZDif @vTZ, @TZ OUTPUT
IF(@LeaseOrg<>194 )
	BEGIN
     SELECT DISTINCT
		Call.CallID,	
		Cast(DATEADD(hh, @TZ, LogEventDateTime) as time(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
		''AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LogEventDateTime,
		CASE 
			WHEN (CAll.calltypeid = 1 and 1 = (Select count(ReferralTypeID) from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID))) then (Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID))
			WHEN (CAll.calltypeid = 6) THEN 'OAS'
			Else 'UNK' 
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		
	  (select 
		case 
		when (SELECT TOP 1
		  [OrganizationPageInterval]
			FROM [Organization]
			where OrganizationID = logevent.organizationid and OrganizationPageInterval <> 0) 
			<> 0 then organizationpageinterval
			else (SELECT TOP 1
			[expirationminutes]
			FROM OrganizationDashBoardTimer
			where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg ) 
			end 
			 from organization
			--if the orgid is -1 or 0 then use statline default interval 
			where OrganizationID = 
			CASE logevent.organizationid
			WHEN -1  then 194
			WHEN 0 then 194
			ELSE logevent.organizationid
			END) as interval,
			Case
				When(LogEvent.LogEventOrg = 'DonorNet') then 0
				Else 1
			end as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		(select TOP 1 PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) from Person where PersonID = (select PersonID from statemployee where StatEmployeeID = LogEventLock.StatEmployeeID))
		 InQueue,'' as CanOpenPopUp,LogEvent.LogEventID
	FROM LogEvent
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	Left join logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	JOIN Referral  ON Referral.CallID = Call.CallID
	
	WHERE 	
		(
			(
				LogEvent.LogEventTypeID = 21 --email pending
				and 
				Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID = @LeaseOrg )
				and
				LogEvent.LogEventCallbackPending=-1
				
			)
			or
			(
				LogEvent.LogEventTypeID =40 -- labs pending
				AND	LogEvent.LogEventCallbackPending=-1
			)		
			OR
			(
				LogEvent.LogEventTypeID = 6 --page pending
				and 
				Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID = @LeaseOrg )
				and
				LogEvent.LogEventCallbackPending=-1
			) 
			or
			(	
				LogEvent.LogEventTypeID = 18 --fax pending
				AND	LogEvent.LogEventCallbackPending=-1
			)
			or
			(	
				LogEvent.LogEventTypeID = 43 --online review pending
				AND	LogEvent.LogEventCallbackPending=-1
			)
			OR
			(
			--callout pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 14
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 2))
			and getdate() > LogEventCalloutDateTime)
			and LogEvent.LogEventCallbackPending=-1 
			and Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID = @LeaseOrg )
			)
			OR
			(
			--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 39
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 2))
			and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes)
			and LogEvent.LogEventCallbackPending=-1 
			)
			OR
			(
			--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 45 --Declared CTOD Pending
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 3))
			--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
				)
			and LogEvent.LogEventCallbackPending=-1 
			)
			OR
			(
			--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 48 --Organ Med RO Pending
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 4))
			--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
				)
			and LogEvent.LogEventCallbackPending=-1 
			)
		)
	and Call.SourceCodeID IN
	(SELECT WebReportGroupSourceCode.SourceCodeID
			FROM WebReportGroup
			JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
			WHERE WebReportGroup.OrgHierarchyParentID = @LeaseOrg)
	and ISNULL(PATINDEX(@OrgName,isnull(LogEvent.LogEventOrg,0)), -1) <> 0
	
UNION ALL	
	SELECT DISTINCT	
		Call.CallID,
		Cast(DATEADD(hh, @TZ, LogEventDateTime) as time(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
		'MESSAGE'AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LastModified,
		CASE
			WHEN (CAll.calltypeid = 2) THEN 'M' 
			WHEN (CAll.calltypeid = 4) THEN 'I' 
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		 
  (select --if you have a legit org id and its not null or 0 use that interval, else use statline
		case 
		when (SELECT TOP 1
		  [OrganizationPageInterval]
			FROM [Organization]
			where OrganizationID = logevent.organizationid and OrganizationPageInterval <> 0) 
			<> 0 then organizationpageinterval
			else (SELECT TOP 1
			[expirationminutes]
			FROM OrganizationDashBoardTimer
			where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg )  
			end 
			 from organization
			--if the orgid is -1 or 0 then use statline default interval 
			where OrganizationID = 
			CASE logevent.organizationid
			WHEN -1  then 194
			WHEN 0 then 194
			ELSE logevent.organizationid
			END) as interval,
		Case
			When(LogEvent.LogEventOrg = 'DonorNet') then 0
			Else 1
		end as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		(select TOP 1 PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) from Person where PersonID = (select PersonID from statemployee where StatEmployeeID = LogEventLock.StatEmployeeID))
		 InQueue,'' as CanOpenPopUp,LogEvent.LogEventID
	FROM LogEvent
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	Left join logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	JOIN Message  ON Message.CallID = Call.CallID 
	
	WHERE 	
		(
		LogEvent.LogEventTypeID IN(6,18, 21, 40, 43)
		OR
		--callout pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 14 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 2))
		and getdate() > LogEventCalloutDateTime)
		OR
		--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 39 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 2))
		and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes)
		OR
		--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid 
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 45 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 3)) --Declared CTOD Update Functionality
		--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
			)
		OR
		--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid 
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 48 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 4)) --Organ Med RO Event Update Functionality
		--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
			)
		)
	AND	LogEvent.LogEventCallbackPending=-1
	and Call.SourceCodeID IN
						(
							SELECT
								WebReportGroupSourceCode.SourceCodeID
							FROM
								WebReportGroup
							JOIN	
								WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
							WHERE
								WebReportGroup.OrgHierarchyParentID = @LeaseOrg)
	and ISNULL(PATINDEX(@OrgName,isnull(LogEvent.LogEventOrg,0)), -1) <> 0
	ORDER BY
	donornetsort,
	 LogEvent.LogEventDateTime 
END
IF(@LeaseOrg=194 )
	BEGIN
     SELECT DISTINCT
		Call.CallID,	
		Cast(DATEADD(hh, @TZ, LogEventDateTime) as time(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
		''AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LogEventDateTime,
		CASE 
			WHEN (CAll.calltypeid = 1 and 1 = (Select count(ReferralTypeID) from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID))) then (Select ReferralAbbreviation from referraltype where ReferralTypeID = abs(Referral.CurrentReferralTypeID))
			WHEN (CAll.calltypeid = 6) THEN 'OAS'
			Else 'UNK'  
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		
	  (select 
		case 
		when (SELECT TOP 1
		  [OrganizationPageInterval]
			FROM [Organization]
			where OrganizationID = logevent.organizationid and OrganizationPageInterval <> 0) 
			<> 0 then organizationpageinterval
			else (SELECT TOP 1
			[expirationminutes]
			FROM OrganizationDashBoardTimer
			where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg ) 
			end 
			 from organization
			--if the orgid is -1 or 0 then use statline default interval 
			where OrganizationID = 
			CASE logevent.organizationid
			WHEN -1  then 194
			WHEN 0 then 194
			ELSE logevent.organizationid
			END) as interval,
			Case
				When(LogEvent.LogEventOrg = 'DonorNet') then 0
				Else 1
			end as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		(select TOP 1 PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) from Person where PersonID = (select PersonID from statemployee where StatEmployeeID = LogEventLock.StatEmployeeID))
		 InQueue,'' as CanOpenPopUp,LogEvent.LogEventID
	FROM LogEvent
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	Left join logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	JOIN Referral  ON Referral.CallID = Call.CallID
	
	WHERE 	
		(
			(
				LogEvent.LogEventTypeID = 21 
				and 
				Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID <> @LeaseOrg )
				and
				LogEvent.LogEventCallbackPending=-1
			)
			or
			(
				LogEvent.LogEventTypeID =40
				AND	LogEvent.LogEventCallbackPending=-1
			)		
			OR
			(
				LogEvent.LogEventTypeID = 6 
				and 
				Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID <> @LeaseOrg )
				and
				LogEvent.LogEventCallbackPending=-1
			) 
			or
			(	
				LogEvent.LogEventTypeID = 18
				AND	LogEvent.LogEventCallbackPending=-1
			)
			or
			(	
				LogEvent.LogEventTypeID = 43
				AND	LogEvent.LogEventCallbackPending=-1
			)

			OR
			(
			--callout pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 14 
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 2))
			and getdate() > LogEventCalloutDateTime)
			and LogEvent.LogEventCallbackPending=-1 
			and Call.CallID not  IN(SELECT CallId FROM FSCase WHERE FSCaseOpenUserId <> 0 AND FSCaseFinalUserId = 0 and Organization.OrganizationID <> @LeaseOrg )
			)
			OR
			(
			--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 39 
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 2))
			and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes)
			and LogEvent.LogEventCallbackPending=-1 
			)
			OR
			(
			--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid 
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 45 
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 3)) --Declared CTOD Update Functionality
			--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
				)
			and LogEvent.LogEventCallbackPending=-1 
			)
			OR
			(
			--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid 
			LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 48 
			and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
			and DashBoardDisplaySettingId = 4)) --Organ Med RO Event Update Functionality
			--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
				)
			and LogEvent.LogEventCallbackPending=-1 
			)
		)
	AND	Organization.OrganizationLOTriageEnabled = @triageEnabled
	and Call.SourceCodeID IN
	(SELECT WebReportGroupSourceCode.SourceCodeID
			FROM WebReportGroup
			JOIN WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
			WHERE WebReportGroup.OrgHierarchyParentID = @LeaseOrg)
	and organization.OrganizationID = ISNULL(@leaseorg1, organization.OrganizationID )
	and ISNULL(PATINDEX(@OrgName,isnull(LogEvent.LogEventOrg,0)), -1) <> 0
	
UNION ALL	
	SELECT DISTINCT	
		Call.CallID,
		Cast(DATEADD(hh, @TZ, LogEventDateTime) as time(0)) AS 'LogEventTime',
		LogEvent.LogEventName, 
		LogEvent.LogEventOrg,
		PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
		'MESSAGE'AS Spacer,
		LogEventCalloutDateTime,
		LogEvent.LastModified,
		CASE 
			WHEN (CAll.calltypeid = 2) THEN 'M' 
			WHEN (CAll.calltypeid = 4) THEN 'I' 
		END as CallType,
		LogEvent.LogEventTypeID,
		person.OrganizationID,
		@expirationminutes as expirationminutes,
		@overexpirationminutes as overexpirationminutes,
		@acknowledgeevalexpireminutes as acknowledgeevalexpireminutes,
		 
  (select --if you have a legit org id and its not null or 0 use that interval, else use statline
		case 
		when (SELECT TOP 1
		  [OrganizationPageInterval]
			FROM [Organization]
			where OrganizationID = logevent.organizationid and OrganizationPageInterval <> 0) 
			<> 0 then organizationpageinterval
			else (SELECT TOP 1
			[expirationminutes]
			FROM OrganizationDashBoardTimer
			where DashBoardWindowId=2 and DashBoardTimerTypeID = 2 and OrganizationID = @LeaseOrg )  
			end 
			 from organization
			--if the orgid is -1 or 0 then use statline default interval 
			where OrganizationID = 
			CASE logevent.organizationid
			WHEN -1  then 194
			WHEN 0 then 194
			ELSE logevent.organizationid
			END) as interval,
		Case
			When(LogEvent.LogEventOrg = 'DonorNet') then 0
			Else 1
		end as donornetsort,
		logeventlock.CallID  as CallLocked,
		logeventlock.StatEmployeeID  as StatEmployeeID,
		(select TOP 1 PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) from Person where PersonID = (select PersonID from statemployee where StatEmployeeID = LogEventLock.StatEmployeeID))
		 InQueue,'' as CanOpenPopUp,LogEvent.LogEventID
	FROM LogEvent
	JOIN Call ON Call.CallID = LogEvent.CallID
	LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID
	LEFT JOIN Person ON Person.PersonID = StatEmployee.PersonID
	Left join logeventlock on LogEventLock.LogEventID = LogEvent.LogEventID
	LEFT JOIN Organization ON Organization.OrganizationID = Person.OrganizationID
	LEFT JOIN SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID -- Added for LO
	JOIN Message  ON Message.CallID = Call.CallID 
	
	WHERE 	
		(
		LogEvent.LogEventTypeID IN(6,18, 21, 40, 43)
		OR
		--callout pending only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 14 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 2))
		and getdate() > LogEventCalloutDateTime)
		OR
		--Acknowledge to Evaluate only shows if org is in OrganizationDisplaySetting table for orgid and only show when expired
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 39 
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 2))
		and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes)
		OR
		--Declared CTOD Pending only shows if org is in OrganizationDisplaySetting table for orgid
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 45 -- Declared CTOD Pending
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 3)) --Declared CTOD Update Functionality
		--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
			)
		OR
		--Organ Med RO Pending only shows if org is in OrganizationDisplaySetting table for orgid
		LogEvent.LogEventID IN (SELECT LogEventID FROM LogEvent Where LogEventTypeID = 48 -- Organ Med RO Pending
		and (0 <> (SELECT DashBoardDisplaySettingId from OrganizationDisplaySetting WHERE OrganizationId = @LeaseOrg 
		and DashBoardDisplaySettingId = 4)) --Organ Med RO Event Update Functionality
		--and DateDiff(n, LogEvent.LogEventDateTime, getdate()) > @acknowledgeevalexpireminutes
			)		
		)
	AND	LogEvent.LogEventCallbackPending=-1
	AND	Organization.OrganizationLOTriageEnabled = @triageEnabled 
	and Call.SourceCodeID IN
						(
							SELECT
								WebReportGroupSourceCode.SourceCodeID
							FROM
								WebReportGroup
							JOIN	
								WebReportGroupSourceCode ON WebReportGroupSourceCode.WebReportGroupID = WebReportGroup.WebReportGroupID 
							WHERE
								WebReportGroup.OrgHierarchyParentID = @LeaseOrg)
	and ISNULL(PATINDEX(@OrgName,isnull(LogEvent.LogEventOrg,0)), -1) <> 0
	ORDER BY
	donornetsort,
	 LogEvent.LogEventDateTime 
END