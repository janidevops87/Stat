SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_DonorTracUpdateBatchEventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_DonorTracUpdateBatchEventLog]';
	drop procedure [dbo].[sps_DonorTracUpdateBatchEventLog];
END
PRINT 'Creating procedure [sps_DonorTracUpdateBatchEventLog]'

GO

CREATE PROCEDURE sps_DonorTracUpdateBatchEventLog
		@vUserName as varchar(50),
		@vPassWord as varchar(50),

		@PreviousDay as datetime,
		@CurrentDay as datetime
AS
/******************************************************************************
**		File: 
**		Name: sps_DonorTracUpdateBatchEventLog
**		Desc: Provides a list of eventlogs for StatTrac WebService 
**
**              
**		Return values: returns the inserted record
**		
** 
**		Called by:   Statline.StatInfo
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: Thien Ta
**		Date: Unknown
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			------------------------------------------
**		Unknown		Thien Ta			initial
**		09/16/07		Bret Knoll		8.4 Added LogEventDeleted
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**      07/09       jth					Comment webreport group code and now join to function
**		04/08/2011	Bret Knoll			Added check For CallActive WI 8311
**		03/17/2015	Bret Knoll			Converted to fn_rpt_ConvertDateTime
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 


	declare
		@SourcecodeID as varchar(10),
		@WebReportID as varchar(10),
		@vOrgID as int,
		@vSourceCode as int,
		@vReportGroupID as int,
		
		@vSourceCodeName as varchar(10),
		@vSourceCodeIDRef as int,
		@webReportGroupName varchar(100),
		@TargetHashedPassword VARCHAR(100);

	SELECT @TargetHashedPassword =  CONVERT(VARCHAR(100),HASHBYTES('SHA1',@vPassWord+ CONVERT(VARCHAR(100),[SaltValue])), 2)
		FROM [dbo].[WebPerson]
		JOIN 	Person ON Person.PersonID = WebPerson.PersonID
		WHERE [WebPersonUserName] = @vUserName 
		AND 	Person.Inactive <> 1;


SELECT 	@vOrgID = Person.OrganizationID
FROM	WebPerson
JOIN	Person ON Person.PersonID = WebPerson.PersonID
WHERE 	WebPersonUserName = @vUserName
AND 	HashedPassword = @TargetHashedPassword;


--Add for conversion of datetime range previousday currentday T.T 08/08/2005 dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified) as LastModified
set @CurrentDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @CurrentDay, 0);  
set @PreviousDay =  dbo.fn_rpt_ConvertDateTime(@vOrgID, @PreviousDay, 0)  ;

--Get SourceCode

select   @vSourceCode = SourcecodeID from sourceCodeOrganization where OrganizationID = @vOrgID;


-- Get SourceCode Name
select @vSourceCodeName = SourcecodeName from Sourcecode where SourcecodeID = @vSourceCode;


-- Get sourcecodeType
select  @vSourceCodeIDRef = SourcecodeID from sourcecode where sourcecodeName = @vSourceCodeName and sourcecodeType = 1 and sourcecode.sourcecodeID <>170;


/* FileReferralEvents2004 */ 
SELECT DISTINCT 
	Convert(varchar,dbo.fn_rpt_ConvertDateTime(@vOrgID,  LogEvent.LastModified, 0 ),121) as LastModified, 
	LogEventID, 
	ReferralID, 
	CallNumber, 
	LogEvent.LogEventTypeID, 
	LogEventTypeName, 
	CONVERT(varchar,dbo.fn_rpt_ConvertDateTime(@vOrgID, LogEventDateTime, 0),121) as LogEventDateTime, 
	LogEvent.PersonID, 
	LogEventName, 
	LogEventPhone, 
	LogEvent.OrganizationID, 
	LogEventOrg, 
	REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',
	StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, 
	ReferralEventAttnTo = CASE LogEvent.LogEventTypeID 
							WHEN 18 THEN DocumentTo 
							WHEN 19 THEN DocumentTo 
							ELSE NULL 
						 END, 
	DateDiff(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, 
	Cast(DatePart(hh,LogEventCalloutDateTime) AS Varchar) + ':' + 
	Cast(DatePart(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, 
	LogEventContactConfirmed AS ReferralEventContactConfirm, 
	ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId 
							WHEN 18 THEN FaxNumber 
							WHEN 19 THEN FaxNumber 
							ELSE NULL 
						END, 
	ReferralEventDocName = CASE LogEvent.LogEventTypeId 
							WHEN 18 THEN FormName 
							WHEN 19 THEN FormName 
							ELSE NULL 
						   END 

FROM 
	Call 
JOIN LogEvent ON LogEvent.CallID = Call.CallID 
JOIN Referral ON Referral.CallID = Call.CallID
LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
LEFT JOIN StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID  
JOIN 
	(
SELECT 		
			SourceCodeID, 
			OrgID
		FROM dbo.fn_GetStatInfoReportWebGroups 
		(
		@vUserName)) fn ON fn.sourcecodeid =call.sourcecodeid and fn.orgid = ReferralCallerOrganizationID 
LEFT JOIN DocumentRequestQueue ON DocumentRequestQueue.CallId = LogEvent.CallId AND DocumentRequestQueue.DocumentSentById = LogEvent.StatEmployeeID 
WHERE 
	Call.CallDateTime >=  @PreviousDay AND Call.CallDateTime <= @CurrentDay 
AND
	(LogEvent.LogEventDeleted IS NULL OR LogEvent.LogEventDeleted = 0)
AND
	(Call.CallActive IS NULL OR Call.CallActive = -1)
		
ORDER BY 
	ReferralID;
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

