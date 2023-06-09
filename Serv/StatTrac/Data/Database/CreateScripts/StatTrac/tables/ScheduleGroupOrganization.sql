if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ScheduleGroupOrganization]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ScheduleGroupOrganization]
GO

CREATE TABLE [dbo].[ScheduleGroupOrganization] (
	[ScheduleGroupOrganizationID] [int] IDENTITY (1, 1) NOT NULL ,
	[ScheduleGroupID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


