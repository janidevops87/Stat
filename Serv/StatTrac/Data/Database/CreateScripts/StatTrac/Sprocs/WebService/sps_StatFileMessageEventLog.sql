SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_StatFileMessageEventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_StatFileMessageEventLog]
GO

CREATE Procedure sps_StatFileMessageEventLog
	@vUserName as varchar(50),
	@vPassword as varchar(50),
	@vStartDateTime as datetime,
	@vEndDateTime as datetime,
	@vCreated bit,
	@vModified bit,
	@vLastRecord as int = 0
AS

/******************************************************************************
**		File: 
**		Name: sps_StatFileMessageEventLog
**		Desc: 
**
**		This template can be customized:
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-----------------------------------**		09/16/07		Bret Knoll		8.4 Added LogEventDeleted
**    
*******************************************************************************/
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

DECLARE @vnumRec int,
		@vOrgID int

-- DETERMINE Possible LogEvents
DECLARE @EventID_Table TABLE
	(
		LogEventID int
	)

INSERT @EventID_Table
	SELECT LogEventID From dbo.fn_GetLogEventIDList(@vStartDateTime, @vEndDateTime, @vCreated, @vModified)
SET @vnumRec = 0

SET @vOrgID	= dbo.fn_GetOrganizationID(@vUserName, @vPassword)

SELECT top 1 @vnumRec = recordsreturned from StatFileOrgFrequency where OrgID = @vOrgID

set rowcount @vnumRec

SELECT DISTINCT 
	LogEventID, 
	Convert(char(25),dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEvent.LastModified),120) as LastModified, 
	LogEventID, 
	MessageID, 
	CallNumber, 
	LogEvent.LogEventTypeID, 
	LogEventTypeName,Convert(char(25), dbo.fn_StatFile_ConvertDateTime(@vOrgID, LogEventDateTime),120) as LogEventDateTime, 
	LogEvent.PersonID, 
	LogEventName, 
	LogEventPhone, 
	LogEvent.OrganizationID, 
	LogEventOrg, 
	REPLACE(REPLACE(LogEventDesc, CHAR(10), CHAR(32)), CHAR(13), '') AS 'LogEventDesc',  
	StatEmployeeFirstName + ' ' + StatEmployeeLastName AS LogEventCreatedBy 
FROM 
	Call 
JOIN 
	LogEvent ON LogEvent.CallID = Call.CallID
LEFT JOIN 
	LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
LEFT JOIN 
	StatEmployee ON StatEmployee.StatEmployeeID = Call.StatEmployeeID 
JOIN 
	Message ON Message.CallID = LogEvent.CallID 

WHERE 
	LogEventID IN (SELECT LogEventID FROM @EventID_Table)	
AND 
	Message.OrganizationID = @vOrgID  

AND 
	LogEventID > @vLastRecord  
AND
	ISNULL(LogEvent.LogEventDeleted, 0)	= 0	
ORDER BY LogEventID



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

