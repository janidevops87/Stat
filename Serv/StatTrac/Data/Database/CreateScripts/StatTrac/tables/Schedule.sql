if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Schedule]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Schedule]
GO

CREATE TABLE [dbo].[Schedule] (
	[ScheduleID] [int] IDENTITY (1, 1) NOT NULL ,
	[OrganizationID] [int] NULL ,
	[PhoneID] [int] NULL ,
	[ScheduleGroupID] [int] NULL ,
	[ScheduleShiftID] [int] NULL ,
	[ScheduleShiftCutover] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleDate] [smalldatetime] NULL ,
	[ScheduleCall1PersonID] [int] NULL ,
	[ScheduleCall2PersonID] [int] NULL ,
	[ScheduleCall3PersonID] [int] NULL ,
	[ScheduleCall4PersonID] [int] NULL ,
	[ScheduleCall5PersonID] [int] NULL ,
	[ScheduleCall6PersonID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UnusedField] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


