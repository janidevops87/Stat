SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelDRDSN](
	[ServiceLevelDRDSNID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DRDSNID] [smallint] NOT NULL,
	[ServiceLevelID] [int] NOT NULL,
	[LastModified] [smalldatetime] NULL,
	[CreateDate] [smalldatetime] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[ServiceLevelDRDSNID] ASC,
	[DRDSNID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]') AND name = N'IX_ServiceLevelDRDSN_ServiceLevelID')
CREATE NONCLUSTERED INDEX [IX_ServiceLevelDRDSN_ServiceLevelID] ON [dbo].[ServiceLevelDRDSN]
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]'))
ALTER TABLE [dbo].[ServiceLevelDRDSN]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID] FOREIGN KEY([DRDSNID])
REFERENCES [dbo].[DRDSN] ([DRDSNID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]'))
ALTER TABLE [dbo].[ServiceLevelDRDSN] CHECK CONSTRAINT [FK_dbo_ServiceLevelDRDSN_DRDSNID_dbo_DRDSN_DRDSNID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]'))
ALTER TABLE [dbo].[ServiceLevelDRDSN]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID] FOREIGN KEY([ServiceLevelID])
REFERENCES [dbo].[ServiceLevel] ([ServiceLevelID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelDRDSN]'))
ALTER TABLE [dbo].[ServiceLevelDRDSN] CHECK CONSTRAINT [FK_dbo_ServiceLevelDRDSN_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]
GO
