if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveLogEvent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveLogEvent]
GO

CREATE TABLE [dbo].[ArchiveLogEvent] (
	[LogEventID] [int] NOT NULL ,
	[CallID] [int] NULL ,
	[LogEventTypeID] [int] NULL ,
	[LogEventDateTime] [smalldatetime] NULL ,
	[LogEventNumber] [int] NULL ,
	[LogEventName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LogEventPhone] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LogEventOrg] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LogEventDesc] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StatEmployeeID] [int] NULL ,
	[LogEventCallbackPending] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[ScheduleGroupID] [int] NULL ,
	[PersonID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[PhoneID] [int] NULL ,
	[LogEventContactConfirmed] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[LogEventCalloutDateTime] [smalldatetime] NULL ,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LogEventDeleted] [bit] DEFAULT 0
) ON [PRIMARY]
GO


