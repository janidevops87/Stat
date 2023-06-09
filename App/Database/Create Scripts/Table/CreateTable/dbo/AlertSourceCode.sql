SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AlertSourceCode]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AlertSourceCode](
	[AlertSourceCodeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AlertID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK___3__15] PRIMARY KEY CLUSTERED 
(
	[AlertSourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AlertSourceCode]') AND name = N'AlertID')
CREATE NONCLUSTERED INDEX [AlertID] ON [dbo].[AlertSourceCode]
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AlertSourceCode]') AND name = N'SourceCodeID')
CREATE NONCLUSTERED INDEX [SourceCodeID] ON [dbo].[AlertSourceCode]
(
	[SourceCodeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertSourceCode]'))
ALTER TABLE [dbo].[AlertSourceCode]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID] FOREIGN KEY([AlertID])
REFERENCES [dbo].[Alert] ([AlertID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertSourceCode]'))
ALTER TABLE [dbo].[AlertSourceCode] CHECK CONSTRAINT [FK_dbo_AlertSourceCode_AlertID_dbo_Alert_AlertID]
GO
