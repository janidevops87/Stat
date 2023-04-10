IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'DashboardRecycleRestoreMessagesSelect')
	BEGIN
		PRINT 'Dropping Procedure DashboardRecycleRestoreMessagesSelect'
		DROP Procedure DashboardRecycleRestoreMessagesSelect
	END
GO
PRINT 'Creating Procedure DashboardRecycleRestoreMessagesSelect'
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/******************************************************************************
**	File: DashboardRecycleRestoreMessagesSelect.sql
**	Name: DashboardRecycleRestoreMessagesSelect
**	Desc: List data before message is restored
**	Auth: jth
**	Date: Feb 2011
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
*******************************************************************************/

CREATE PROCEDURE DashboardRecycleRestoreMessagesSelect
	@callID INT
AS

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED 

SELECT 
      MessageCallerName,
      MessageCallerOrganization,SourceCodeName,
      MessageImportUNOSID, Organization.OrganizationName, LogEvent.LogEventDateTime,PersonFirst + ' ' + SUBSTRING(PersonLast,1,1) CreatedBy,
      LogEventTypeName,LogEventOrg,LogEventDesc,LogEventNumber,LogEventName
FROM LogEvent 
LEFT JOIN LogEventType ON LogEventType.LogEventTypeID = LogEvent.LogEventTypeID 
JOIN StatEmployee ON LogEvent.StatEmployeeID = StatEmployee.StatEmployeeID 
JOIN Person ON Person.PersonID = StatEmployee.PersonID 
left join message on message.CallID = LogEvent.CallID
LEFT JOIN CallRecycle Call ON Call.CallID = Message.CallID
LEFT JOIN 	SourceCode ON SourceCode.SourceCodeID = Call.SourceCodeID 	
LEFT JOIN 	Organization ON Organization.OrganizationID = Message.OrganizationID 
  
where LogEvent.CallID = @callID
ORDER BY 
	LogEventDateTime ,
	LogEventNumber ;  