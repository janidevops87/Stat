if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleGroupPerson]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleGroupPerson]
GO

CREATE TABLE [dbo].[ScheduleGroupPerson] (
	[ScheduleGroupPersonID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NOT NULL ,
	[PersonID] [int] NOT NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


