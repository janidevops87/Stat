
IF EXISTS (SELECT * FROM sysobjects WHERE type = 'P' AND name = 'CtodCloseOut')
BEGIN
	PRINT 'Dropping Procedure CtodCloseOut'
	DROP  Procedure CtodCloseOut
END
GO

PRINT 'Creating Procedure CtodCloseOut'
GO
CREATE Procedure CtodCloseOut AS
 /******************************************************************************
**		File: CtodCloseOut.sql
**		Desc: Closes out old Cardiac Time Of Death Events
**		Auth: Bret Knoll
**		Date: 04/02/2012
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:			Author:			Description:
**		--------		--------		-------------------------------------------
**		04/02/2012		Bret			Initial										
*******************************************************************************/


UPDATE	logevent
SET		logEvent.LogEventCallbackPending = 0

from	call c
join	logevent le on c.callid = le.callid
join	LogEventType lt on le.LogEventTypeID = lt.LogEventTypeID
join	SourceCode sc ON c.SourceCodeID = sc.SourceCodeID
join	StatEmployee se on le.LastStatEmployeeID = se.StatEmployeeID
join	Person on se.PersonID = Person.PersonID
join	Organization o on Person.OrganizationID = o.OrganizationID
where	le.LogEventCallbackPending = -1
and		le.LastModified < DATEADD(WEEK, -2, GETDATE())
and		Person.OrganizationID not in
		(
		 select OrganizationId    from OrganizationDisplaySetting od  where DashBoardDisplaySettingId = 3
		 )
and		lt.LogEventTypeID = 45

		