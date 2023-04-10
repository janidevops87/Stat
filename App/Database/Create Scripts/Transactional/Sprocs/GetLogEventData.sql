IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'GetLogEventData')
	BEGIN
		PRINT 'Dropping Procedure GetLogEventData'
		DROP  Procedure  GetLogEventData
	END

GO

PRINT 'Creating Procedure GetLogEventData'
GO
CREATE Procedure GetLogEventData
	@CallID INT

AS

/******************************************************************************
**		File: GetLogEventData.sql
**		Name: GetLogEventData
**		Desc: Gets LogEvents data
**              
**		Return values:
** 
**		Called by:   
**              
**		Parameters:
**		Input							Output
**     ----------							-----------
**
**		Auth: ccarroll	
**		Date: 11/01/2008
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		11/01/2008	ccarroll			
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
	PhoneID,
	LogEventContactConfirmed,
	UpdatedFlag,
	LogEventCalloutDateTime,
	LastStatEmployeeID,
	AuditLogTypeID,
	LogEventDeleted

FROM 
	LogEvent 
WHERE 
	LogEvent.CallID = @CallID 

GO

