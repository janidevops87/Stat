if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleShift]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleShift]
GO

CREATE TABLE [dbo].[ScheduleShift] (
	[ScheduleShiftID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NULL ,
	[ScheduleShiftName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[WeekdayID] [int] NULL ,
	[ScheduleShiftStartTime] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleShiftEndTime] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[ScheduleShiftDate] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


