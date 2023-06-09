if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SCScheduleGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SCScheduleGroup]
GO

CREATE TABLE [dbo].[SCScheduleGroup] (
	[SCScheduleGroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NOT NULL ,
	[SubCriteriaID] [int] NOT NULL ,
	[SCScheduleGroupOrgan] [smallint] NULL ,
	[SCScheduleGroupBone] [smallint] NULL ,
	[SCScheduleGroupTissue] [smallint] NULL ,
	[SCScheduleGroupSkin] [smallint] NULL ,
	[SCScheduleGroupValves] [smallint] NULL ,
	[SCScheduleGroupEyes] [smallint] NULL ,
	[SCScheduleGroupResearch] [smallint] NULL ,
	[SCScheduleNoContactOnDny] [smallint] NULL ,
	[SCScheduleContactOnCnsnt] [smallint] NULL ,
	[SCScheduleContactOnAprch] [smallint] NULL ,
	[SCScheduleContactOnCrnr] [smallint] NULL ,
	[SCScheduleContactOnStatSec] [smallint] NULL ,
	[SCScheduleContactOnStatCnsnt] [smallint] NULL ,
	[SCScheduleContactOnCoronerOnly] [smallint] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


