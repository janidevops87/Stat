if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleGroup]
GO

CREATE TABLE [dbo].[ScheduleGroup] (
	[ScheduleGroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[OrganizationID] [int] NULL ,
	[ScheduleGroupName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[ScheduleGroupReferralNotes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleGroupMessageNotes] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ScheduleGroupCode] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[UseNewSchedule] [smallint] NULL 
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


