if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleGroupSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleGroupSourceCode]
GO

CREATE TABLE [dbo].[ScheduleGroupSourceCode] (
	[ScheduleGroupSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[Unused] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


