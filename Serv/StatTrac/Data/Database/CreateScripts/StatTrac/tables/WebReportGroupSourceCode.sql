if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[WebReportGroupSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[WebReportGroupSourceCode]
GO

CREATE TABLE [dbo].[WebReportGroupSourceCode] (
	[WebReportGroupSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[WebReportGroupID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[AccessOrgans] [smallint] NULL ,
	[AccessBone] [smallint] NULL ,
	[AccessTissue] [smallint] NULL ,
	[AccessSkin] [smallint] NULL ,
	[AccessValves] [smallint] NULL ,
	[AccessEyes] [smallint] NULL ,
	[AccessResearch] [smallint] NULL ,
	[AccessOrgansUpdate] [smallint] NULL ,
	[AccessBoneUpdate] [smallint] NULL ,
	[AccessTissueUpdate] [smallint] NULL ,
	[AccessSkinUpdate] [smallint] NULL ,
	[AccessValvesUpdate] [smallint] NULL ,
	[AccessEyesUpdate] [smallint] NULL ,
	[AccessResearchUpdate] [smallint] NULL ,
	[AccessTypeOTE] [smallint] NULL ,
	[AccessTypeTE] [smallint] NULL ,
	[AccessTypeEOnly] [smallint] NULL ,
	[AccessTypeRuleout] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


