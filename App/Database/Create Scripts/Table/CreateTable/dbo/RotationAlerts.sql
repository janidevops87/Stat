SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationAlerts]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationAlerts](
	[Rotationid] [int] NULL,
	[RotationGroupID] [int] NULL,
	[AlertID] [int] NULL,
	[AlertType] [int] NULL,
	[AlertGroupName] [varchar](50) NULL,
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationAlerts]') AND name = N'IX_RotationGroupId')
CREATE NONCLUSTERED INDEX [IX_RotationGroupId] ON [dbo].[RotationAlerts]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationAlerts]') AND name = N'IX_RotationId')
CREATE NONCLUSTERED INDEX [IX_RotationId] ON [dbo].[RotationAlerts]
(
	[Rotationid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[RotationAlerts]'))
ALTER TABLE [dbo].[RotationAlerts]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID] FOREIGN KEY([AlertID])
REFERENCES [dbo].[Alert] ([AlertID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[RotationAlerts]'))
ALTER TABLE [dbo].[RotationAlerts] CHECK CONSTRAINT [FK_dbo_RotationAlerts_AlertID_dbo_Alert_AlertID]
GO
