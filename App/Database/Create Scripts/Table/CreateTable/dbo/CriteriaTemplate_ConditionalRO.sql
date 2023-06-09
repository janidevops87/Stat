SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaTemplate_ConditionalRO](
	[CriteriaTemplate_ConditionalROID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaTemplateId] [int] NULL,
	[FSIndicationId] [int] NULL,
	[FSConditionId] [int] NULL,
	[FSAppropriateId] [int] NULL,
 CONSTRAINT [PK_CriteriaTemplate_ConditionalRO] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaTemplate_ConditionalROID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID] FOREIGN KEY([CriteriaTemplateId])
REFERENCES [dbo].[CriteriaTemplate] ([CriteriaTemplateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO] CHECK CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_CriteriaTemplateId_dbo_CriteriaTemplate_CriteriaTemplateID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID] FOREIGN KEY([FSAppropriateId])
REFERENCES [dbo].[FSAppropriate] ([FSAppropriateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO] CHECK CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_FSAppropriateId_dbo_FSAppropriate_FSAppropriateID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID] FOREIGN KEY([FSIndicationId])
REFERENCES [dbo].[FSIndication] ([FSIndicationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaTemplate_ConditionalRO]'))
ALTER TABLE [dbo].[CriteriaTemplate_ConditionalRO] CHECK CONSTRAINT [FK_dbo_CriteriaTemplate_ConditionalRO_FSIndicationId_dbo_FSIndication_FSIndicationID]
GO
