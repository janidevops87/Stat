IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventByAutoResponseCode')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventByAutoResponseCode'
		DROP  Procedure  GetLogEventByAutoResponseCode
	END

GO

PRINT 'Creating Procedure GetLogEventByAutoResponseCode'
GO
CREATE Procedure GetLogEventByAutoResponseCode
	
	@callId INT,
	@autoResponseCode INT

AS

/******************************************************************************
**		File: GetLogEventByAutoResponseCode.sql
**		Name: GetLogEventByAutoResponseCode
**		Desc: Gets LogEvents data
**              
**		Return values:
** 
**		Called by:   Statline.StatTrac.Data.Table.LogEventDB.UpdateLogEvent
**              
**		Auth: Bret Knoll	
**		Date: 4/26/09
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		04/26/2009	Bret Knoll			initial CCRSTR89
*******************************************************************************/
SELECT     
	LogEventID,
	CallID,
	LogEventTypeID,
	LogEventDateTime,
	LogEventNumber,
	LogEventName,
	LogEventPhone,
	LogEventOrg,
	LogEventDesc,
	StatEmployeeID,
	LogEventCallbackPending,
	LastModified,
	ScheduleGroupID,
	PersonID,
	OrganizationID,
	ISNULL(PhoneID, 0) PhoneID,
	LogEventContactConfirmed,
	UpdatedFlag,
	LogEventCalloutDateTime,
	LastStatEmployeeID,
	AuditLogTypeID,
	LogEventDeleted
FROM  
	LogEvent
WHERE 
	LogEvent.LogEventID =
	(SELECT     TOP 1 LogeventID
	 FROM         AutoResponseCode
	 WHERE     (CallID = @callId) AND (AutoResponseCode = @autoResponseCode)
	 )
GO

