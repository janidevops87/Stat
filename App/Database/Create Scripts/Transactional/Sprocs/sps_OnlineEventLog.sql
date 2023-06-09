SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sps_OnlineEventLog]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sps_OnlineEventLog]
GO




CREATE PROCEDURE sps_OnlineEventLog  
			@vCallID as int,
			@vLogEventTypeID as int = 2,
			@vLogEventName as varchar(30)= 'Online Referral',
			@vLogEventPhone as varchar(30) = '555-5555',
			@vLogEventOrg as varchar(100) = 'AspenValley Hospital',
			@vLogEventDesc as varchar(1000) = 'test'
			
			
AS
/*
INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, 
StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, 
ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber)
 VALUES (@vCallID,@vLogEventTypeID,@vLogEventName,@vLogEventPhone,@vLogEventOrg,@vLogEventDesc,
000,Current_TimeStamp,0,-1,-1,-1,-1,0,NULL,NULL) */


INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, 
LogEventDesc, StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID,
 ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime,
 LogEventNumber) VALUES (@vCallID,2,'Online Hospital Referral',@vLogEventPhone,@vLogEventOrg,
@vLogEventDesc,888,Current_TimeStamp,0,-1,-1,-1,-1,0,NULL,NULL)

/*
INSERT INTO LogEvent (CallID, LogEventTypeID, LogEventName, LogEventPhone, LogEventOrg, LogEventDesc, 
StatEmployeeID, LogEventDateTime, LogEventCallbackPending, OrganizationID, 
ScheduleGroupID, PersonID, PhoneID, LogEventContactConfirmed, LogEventCalloutDateTime, LogEventNumber)
 VALUES (@vCallID,2,'Online Referral','(303) 847-6644','Aspen Valley Hospital','Recorded patient information.',
00,'3/17/2005 11:19:00 AM',0,-1,-1,-1,-1,0,NULL,NULL) */



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

