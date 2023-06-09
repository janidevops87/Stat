SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelCustomList]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelCustomList](
	[ServiceLevelID] [int] NOT NULL,
	[ServiceLevelListField] [smallint] NULL,
	[ServiceLevelListItem] [varchar](40) NULL,
	[ServiceLevelCustomListID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_ServiceLevelCustomList] PRIMARY KEY NONCLUSTERED 
(
	[ServiceLevelCustomListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelCustomList]') AND name = N'IDX_ServiceLevelCustomList_ServiceLevelID_ServiceLevelListField')
CREATE NONCLUSTERED INDEX [IDX_ServiceLevelCustomList_ServiceLevelID_ServiceLevelListField] ON [dbo].[ServiceLevelCustomList]
(
	[ServiceLevelID] ASC,
	[ServiceLevelListField] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelCustomList]'))
ALTER TABLE [dbo].[ServiceLevelCustomList]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID] FOREIGN KEY([ServiceLevelID])
REFERENCES [dbo].[ServiceLevel] ([ServiceLevelID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevelCustomList]'))
ALTER TABLE [dbo].[ServiceLevelCustomList] CHECK CONSTRAINT [FK_dbo_ServiceLevelCustomList_ServiceLevelID_dbo_ServiceLevel_ServiceLevelID]
GO
