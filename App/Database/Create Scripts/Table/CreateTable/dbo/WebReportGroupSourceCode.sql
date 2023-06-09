SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[WebReportGroupSourceCode](
	[WebReportGroupSourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebReportGroupID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[AccessOrgans] [smallint] NULL,
	[AccessBone] [smallint] NULL,
	[AccessTissue] [smallint] NULL,
	[AccessSkin] [smallint] NULL,
	[AccessValves] [smallint] NULL,
	[AccessEyes] [smallint] NULL,
	[AccessResearch] [smallint] NULL,
	[AccessOrgansUpdate] [smallint] NULL,
	[AccessBoneUpdate] [smallint] NULL,
	[AccessTissueUpdate] [smallint] NULL,
	[AccessSkinUpdate] [smallint] NULL,
	[AccessValvesUpdate] [smallint] NULL,
	[AccessEyesUpdate] [smallint] NULL,
	[AccessResearchUpdate] [smallint] NULL,
	[AccessTypeOTE] [smallint] NULL,
	[AccessTypeTE] [smallint] NULL,
	[AccessTypeEOnly] [smallint] NULL,
	[AccessTypeRuleout] [smallint] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___1__20] PRIMARY KEY CLUSTERED 
(
	[WebReportGroupSourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]') AND name = N'WebReportGroupID')
CREATE NONCLUSTERED INDEX [WebReportGroupID] ON [dbo].[WebReportGroupSourceCode]
(
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]') AND name = N'WebReportGroupSourceCode43')
CREATE NONCLUSTERED INDEX [WebReportGroupSourceCode43] ON [dbo].[WebReportGroupSourceCode]
(
	[SourceCodeID] ASC,
	[WebReportGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebReportG_AccessTypeO2__23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebReportGroupSourceCode] ADD  CONSTRAINT [DF_WebReportG_AccessTypeO2__23]  DEFAULT (1) FOR [AccessTypeOTE]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebReportG_AccessTypeT4__23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebReportGroupSourceCode] ADD  CONSTRAINT [DF_WebReportG_AccessTypeT4__23]  DEFAULT (1) FOR [AccessTypeTE]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebReportG_AccessTypeE1__23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebReportGroupSourceCode] ADD  CONSTRAINT [DF_WebReportG_AccessTypeE1__23]  DEFAULT (1) FOR [AccessTypeEOnly]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_WebReportG_AccessTypeR3__23]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[WebReportGroupSourceCode] ADD  CONSTRAINT [DF_WebReportG_AccessTypeR3__23]  DEFAULT (1) FOR [AccessTypeRuleout]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]'))
ALTER TABLE [dbo].[WebReportGroupSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID] FOREIGN KEY([WebReportGroupID])
REFERENCES [dbo].[WebReportGroup] ([WebReportGroupID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]') AND parent_object_id = OBJECT_ID(N'[dbo].[WebReportGroupSourceCode]'))
ALTER TABLE [dbo].[WebReportGroupSourceCode] CHECK CONSTRAINT [FK_dbo_WebReportGroupSourceCode_WebReportGroupID_dbo_WebReportGroup_WebReportGroupID]
GO
