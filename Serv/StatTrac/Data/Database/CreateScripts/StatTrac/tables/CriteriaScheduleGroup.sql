if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaScheduleGroup]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaScheduleGroup]
GO

CREATE TABLE [dbo].[CriteriaScheduleGroup] (
	[CriteriaScheduleGroupID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NULL ,
	[ScheduleGroupID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[CriteriaScheduleGroupOrgan] [smallint] NULL ,
	[CriteriaScheduleGroupBone] [smallint] NULL ,
	[CriteriaScheduleGroupTissue] [smallint] NULL ,
	[CriteriaScheduleGroupSkin] [smallint] NULL ,
	[CriteriaScheduleGroupValves] [smallint] NULL ,
	[CriteriaScheduleGroupEyes] [smallint] NULL ,
	[CriteriaScheduleGroupResearch] [smallint] NULL ,
	[CriteriaScheduleNoContactOnDny] [smallint] NULL ,
	[CriteriaScheduleContactOnCnsnt] [smallint] NULL ,
	[CriteriaScheduleContactOnAprch] [smallint] NULL ,
	[CriteriaScheduleContactOnCrnr] [smallint] NULL ,
	[CriteriaScheduleContactOnStatSec] [smallint] NULL ,
	[CriteriaScheduleContactOnStatCnsnt] [smallint] NULL ,
	[CriteriaScheduleContactOnCoronerOnly] [smallint] NULL 
) ON [PRIMARY]
GO


