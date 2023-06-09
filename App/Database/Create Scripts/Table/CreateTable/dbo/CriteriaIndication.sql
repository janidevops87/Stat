SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaIndication](
	[CriteriaIndicationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NULL,
	[IndicationID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[IndicationHighRisk] [smallint] NULL,
	[IndicationStandardMRO] [smallint] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_CriteriaIndication_1__13] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaIndicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]') AND name = N'CriteriaID')
CREATE NONCLUSTERED INDEX [CriteriaID] ON [dbo].[CriteriaIndication]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]') AND name = N'IndicationID')
CREATE NONCLUSTERED INDEX [IndicationID] ON [dbo].[CriteriaIndication]
(
	[IndicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]'))
ALTER TABLE [dbo].[CriteriaIndication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]'))
ALTER TABLE [dbo].[CriteriaIndication] CHECK CONSTRAINT [FK_dbo_CriteriaIndication_CriteriaID_dbo_Criteria_CriteriaID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]'))
ALTER TABLE [dbo].[CriteriaIndication]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID] FOREIGN KEY([IndicationID])
REFERENCES [dbo].[Indication] ([IndicationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaIndication]'))
ALTER TABLE [dbo].[CriteriaIndication] CHECK CONSTRAINT [FK_dbo_CriteriaIndication_IndicationID_dbo_Indication_IndicationID]
GO
