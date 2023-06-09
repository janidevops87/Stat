if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleLog]
GO

CREATE TABLE [dbo].[ScheduleLog] (
	[ScheduleLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NOT NULL ,
	[ScheduleLogDateTime] [smalldatetime] NULL ,
	[PersonID] [int] NULL ,
	[ScheduleLogType] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleLogShift] [varchar] (80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleLogChange] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


