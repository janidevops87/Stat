if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleItemPerson]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleItemPerson]
GO

CREATE TABLE [dbo].[ScheduleItemPerson] (
	[ScheduleItemPersonID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleItemID] [int] NOT NULL ,
	[PersonID] [int] NOT NULL ,
	[Priority] [smallint] NOT NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


