if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleItem]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleItem]
GO

CREATE TABLE [dbo].[ScheduleItem] (
	[ScheduleItemID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NULL ,
	[ScheduleItemName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleItemStartDate] [smalldatetime] NULL ,
	[ScheduleItemStartTime] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleItemEndDate] [smalldatetime] NULL ,
	[ScheduleItemEndTime] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


