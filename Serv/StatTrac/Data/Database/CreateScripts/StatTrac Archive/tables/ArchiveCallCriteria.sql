if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveCallCriteria]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveCallCriteria]
GO

CREATE TABLE [dbo].[ArchiveCallCriteria] (
	[CallID] [int] NOT NULL ,
	[OrganCriteriaID] [int] NULL ,
	[BoneCriteriaID] [int] NULL ,
	[TissueCriteriaID] [int] NULL ,
	[SkinCriteriaID] [int] NULL ,
	[ValvesCriteriaID] [int] NULL ,
	[EyesCriteriaID] [int] NULL ,
	[OtherCriteriaID] [int] NULL ,
	[ServiceLevelID] [int] NULL 
) ON [PRIMARY]
GO


