if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LogEvent]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LogEvent]
GO

CREATE TABLE [dbo].[LogEvent] (
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
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,	
	[LogEventDeleted] [bit] NULL 
) ON [PRIMARY]
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [PersonID] ON [dbo].[LogEvent] ([PersonID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [OrganizationID] ON [dbo].[LogEvent] ([OrganizationID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_8] ON [dbo].[LogEvent] ([LogEventOrg]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_6] ON [dbo].[LogEvent] ([LogEventName]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_10] ON [dbo].[LogEvent] ([StatEmployeeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_1_11] ON [dbo].[LogEvent] ([LogEventID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_2_11] ON [dbo].[LogEvent] ([CallID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_3_11] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_3_4] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventDateTime]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_4_11] ON [dbo].[LogEvent] ([LogEventDateTime], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_4_3] ON [dbo].[LogEvent] ([LogEventDateTime], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_11_4] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventDateTime]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_4_2] ON [dbo].[LogEvent] ([LogEventDateTime], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_2_4] ON [dbo].[LogEvent] ([CallID], [LogEventDateTime]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_3_2] ON [dbo].[LogEvent] ([LogEventTypeID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_11_3] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_4_1] ON [dbo].[LogEvent] ([LogEventDateTime], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_1_4] ON [dbo].[LogEvent] ([LogEventID], [LogEventDateTime]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_2_3] ON [dbo].[LogEvent] ([CallID], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_3_1] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_11_2] ON [dbo].[LogEvent] ([LogEventCallbackPending], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_1_3] ON [dbo].[LogEvent] ([LogEventID], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_11_1] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_1_2] ON [dbo].[LogEvent] ([LogEventID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_2_1] ON [dbo].[LogEvent] ([CallID], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_11_1_2_3_4_6_8_10] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventID], [CallID], [LogEventTypeID], [LogEventDateTime], [LogEventName], [LogEventOrg], [StatEmployeeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_4_1_2_3_6_8_10_11] ON [dbo].[LogEvent] ([LogEventDateTime], [LogEventID], [CallID], [LogEventTypeID], [LogEventName], [LogEventOrg], [StatEmployeeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_1_2_3_4_6_8_10_11] ON [dbo].[LogEvent] ([LogEventID], [CallID], [LogEventTypeID], [LogEventDateTime], [LogEventName], [LogEventOrg], [StatEmployeeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_2_1_3_4_6_8_10_11] ON [dbo].[LogEvent] ([CallID], [LogEventID], [LogEventTypeID], [LogEventDateTime], [LogEventName], [LogEventOrg], [StatEmployeeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_52_3_1_2_4_6_8_10_11] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventID], [CallID], [LogEventDateTime], [LogEventName], [LogEventOrg], [StatEmployeeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_10] ON [dbo].[LogEvent] ([StatEmployeeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_8] ON [dbo].[LogEvent] ([LogEventOrg]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_6] ON [dbo].[LogEvent] ([LogEventName]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_1_11] ON [dbo].[LogEvent] ([LogEventID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_2_3] ON [dbo].[LogEvent] ([CallID], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_3_2] ON [dbo].[LogEvent] ([LogEventTypeID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_1_3] ON [dbo].[LogEvent] ([LogEventID], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_2_11] ON [dbo].[LogEvent] ([CallID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_3_1] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_1_2] ON [dbo].[LogEvent] ([LogEventID], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_2_1] ON [dbo].[LogEvent] ([CallID], [LogEventID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_3_11] ON [dbo].[LogEvent] ([LogEventTypeID], [LogEventCallbackPending]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_11_3] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventTypeID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_11_2] ON [dbo].[LogEvent] ([LogEventCallbackPending], [CallID]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [hind_55_11_1] ON [dbo].[LogEvent] ([LogEventCallbackPending], [LogEventID]) ')
GO

 CREATE  INDEX [CallID] ON [dbo].[LogEvent]([CallID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE  INDEX [LogEvent0] ON [dbo].[LogEvent]([LogEventCallbackPending], [LogEventID], [CallID], [LogEventTypeID], [LogEventDateTime], [LogEventName], [LogEventOrg], [StatEmployeeID]) WITH  FILLFACTOR = 90 ON [IDX]
GO

 CREATE    INDEX [PK_LogEvent_1__13] ON [dbo].[LogEvent]([LogEventID]) WITH FILLFACTOR = 90 ON [IDX]
GO


