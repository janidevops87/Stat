SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SetDisposition]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SetDisposition](
	[SetDispositionID] [int] NOT NULL,
	[DispositionID] [int] NULL,
	[OptionID] [int] NULL,
	[AppropriateID] [int] NULL,
	[ApproachID] [int] NULL,
	[ConsentID] [int] NULL,
	[RecoveryID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[SetDisposition]') AND name = N'IDX_SetDisposition_OptionId')
CREATE CLUSTERED INDEX [IDX_SetDisposition_OptionId] ON [dbo].[SetDisposition]
(
	[OptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID] FOREIGN KEY([ApproachID])
REFERENCES [dbo].[Approach] ([ApproachID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition] CHECK CONSTRAINT [FK_dbo_SetDisposition_ApproachID_dbo_Approach_ApproachID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID] FOREIGN KEY([AppropriateID])
REFERENCES [dbo].[Appropriate] ([AppropriateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition] CHECK CONSTRAINT [FK_dbo_SetDisposition_AppropriateID_dbo_Appropriate_AppropriateID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID] FOREIGN KEY([ConsentID])
REFERENCES [dbo].[Consent] ([ConsentID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SetDisposition]'))
ALTER TABLE [dbo].[SetDisposition] CHECK CONSTRAINT [FK_dbo_SetDisposition_ConsentID_dbo_Consent_ConsentID]
GO
