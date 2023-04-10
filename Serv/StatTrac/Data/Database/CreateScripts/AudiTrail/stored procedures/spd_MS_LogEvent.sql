 if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spd_MS_LogEvent]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[spd_MS_LogEvent]
GO
SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

create procedure "spd_MS_LogEvent" 
	@pkc1 int
as
INSERT  
	"LogEvent"( 
		"LogEventID",
		"CallID",
		"LogEventTypeID",
		"LogEventDateTime",
		"LogEventNumber",
		"LogEventName",
		"LogEventPhone",
		"LogEventOrg",
		"LogEventDesc",
		"StatEmployeeID",
		"LogEventCallbackPending",
		"LastModified",
		"ScheduleGroupID",
		"PersonID",
		"OrganizationID",
		"PhoneID",
		"LogEventContactConfirmed",
		"UpdatedFlag",
		"LogEventCalloutDateTime"
 )

values ( 
	 @pkc1,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null,
	 null
 )
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO