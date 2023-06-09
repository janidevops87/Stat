SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS OFF;
GO

IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[sps_DonorTracUpdateReferralEventLog]') AND OBJECTPROPERTY(id, N'IsProcedure') = 1)
BEGIN
	PRINT 'Dropping procedure [sps_DonorTracUpdateReferralEventLog]';
	DROP PROCEDURE [dbo].[sps_DonorTracUpdateReferralEventLog];
END
PRINT 'Creating procedure [sps_DonorTracUpdateReferralEventLog]';


GO
CREATE PROCEDURE sps_DonorTracUpdateReferralEventLog
		@vUserName	AS VARCHAR(50),
		@vPassWord	AS VARCHAR(50),
		@CallID		AS VARCHAR(20)
AS
/******************************************************************************
**		File: 
**		Name: sps_DonorTracUpdateReferralEventLog
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
**		09/16/07	Bret Knoll			8.4 Added LogEventDeleted
**		03/18/09	Bret Knoll			Modified what report group dtmtf uses
**      07/09       jth					Comment webreport group code and now join to function
**		10/11/11	Pam Scheichenost	Modified Created By being sent to be person who created
**										the event, not the call
**		03/17/2015	Bret Knoll			Converted to fn_rpt_ConvertDateTime
**		07/20/18	Ilya Osipov			Added HashedPassword code
**  08/15/2018		Ilya Osipov				Removing ReferralTest DB name fro the scripts
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

/* FileReferralEvents2004 */ 
SELECT DISTINCT 
	CONVERT(varchar, dbo.fn_MTToUTC(LogEvent.LastModified),121) as LastModified, 
	LogEventID, 
	Call.CallID, 
	CallNumber, 
	LogEvent.LogEventTypeID, 
	LogEventTypeName, 
	CONVERT(varchar, dbo.fn_MTToUTC(LogEventDateTime),121) as LogEventDateTime, 
	LogEvent.PersonID, 
	LogEventName, 
	LogEventPhone, 
	LogEvent.OrganizationID, 
	LogEventOrg, 
	REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',
	StatEmployeeFirstName + ' ' + StatEmployeeLastName  AS LogEventCreatedBy, 
	ReferralEventAttnTo = CASE LogEvent.LogEventTypeID WHEN 18 THEN DocumentTo WHEN 19 THEN DocumentTo ELSE NULL END, 
	DATEDIFF(n, LogEventDateTime,LogEventCalloutDateTime) AS ReferralEventCalloutMin, 
	CAST(DATEPART(hh,LogEventCalloutDateTime) AS Varchar) + ':' + 
	CAST(DATEPART(mi,LogEventCalloutDateTime) AS Varchar) + ':00' AS ReferralEventCalloutAfter, 
	LogEventContactConfirmed AS ReferralEventContactConfirm, ReferralEventFaxNbr = CASE LogEvent.LogEventTypeId WHEN 18 THEN FaxNumber WHEN 19 THEN FaxNumber ELSE NULL END, 
	ReferralEventDocName = CASE LogEvent.LogEventTypeId WHEN 18 THEN DocumentRequestQueue.FormName WHEN 19 THEN DocumentRequestQueue.FormName ELSE NULL END 
FROM 
	 Call
JOIN 
	LogEvent ON LogEvent.CallID = Call.CallID 
JOIN 
	Referral ON Referral.CallID = LogEvent.CallID
LEFT JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
LEFT JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = LogEvent.StatEmployeeID 
JOIN 
	(SELECT SourceCodeID, 
			OrgID
		FROM dbo.fn_GetStatInfoReportWebGroups 
		(
			@vUserName
		)
	) fn ON fn.SourceCodeID = Call.SourceCodeID AND fn.OrgID = ReferralCallerOrganizationID	 
LEFT JOIN 
	DocumentRequestQueue ON DocumentRequestQueue.CallId = LogEvent.CallId AND DocumentRequestQueue.DocumentSentById = LogEvent.StatEmployeeID  
WHERE 
	Call.CallID = @CallID  
AND
	(LogEvent.LogEventDeleted IS NULL OR LogEvent.LogEventDeleted = 0)
ORDER BY Call.CallID;

GO
SET QUOTED_IDENTIFIER OFF;
GO
SET ANSI_NULLS ON;
GO

