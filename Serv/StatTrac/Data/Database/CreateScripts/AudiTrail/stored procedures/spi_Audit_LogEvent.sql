SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[spi_Audit_LogEvent]') and OBJECTPROPERTY(id,
	N'IsProcedure') = 1)
drop procedure [dbo].[spi_Audit_LogEvent]
GO

create procedure "spi_Audit_LogEvent" @c1 int,
	@c2 int,
	@c3 int,
	@c4 smalldatetime,
	@c5 int,
	@c6 varchar(50),
	@c7 varchar(100),
	@c8 varchar(80),
	@c9 varchar(1000),
	@c10 int,
	@c11 smallint,
	@c12 datetime,
	@c13 int,
	@c14 int,
	@c15 int,
	@c16 int,
	@c17 smallint,
	@c18 smallint,
	@c19 smalldatetime,
	@c20 int,
	@c21 int,	
	@c22 bit

AS
BEGIN


insert into "LogEvent"( 
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
	"LogEventCalloutDateTime",
	"LastStatEmployeeID",
	"AuditLogTypeID",	
	"LogEventDeleted"
	)

values	
	( 
	@c1,
	@c2,
	@c3,
	@c4,
	@c5,
	@c6,
	@c7,
	@c8,
	@c9,
	@c10,
	@c11,
	@c12,
	@c13,
	@c14,
	@c15,
	@c16,
	@c17,
	@c18,
	@c19,
	@c20,
	@c21,
	@c22
	)


END

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

