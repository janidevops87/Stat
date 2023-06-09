SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OnlineHospitalSourceCodeWebPerson](
	[id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[webPersonID] [int] NULL,
	[SourceCodeID] [int] NULL,
	[SourceCodeName] [varchar](50) NULL,
	[Locked] [smallint] NULL,
 CONSTRAINT [PK_OnlineHospitalSourceCodeWebPerson] PRIMARY KEY NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]') AND name = N'PK_WebPersonID')
CREATE UNIQUE CLUSTERED INDEX [PK_WebPersonID] ON [dbo].[OnlineHospitalSourceCodeWebPerson]
(
	[id] ASC,
	[webPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]'))
ALTER TABLE [dbo].[OnlineHospitalSourceCodeWebPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeID])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]'))
ALTER TABLE [dbo].[OnlineHospitalSourceCodeWebPerson] CHECK CONSTRAINT [FK_dbo_OnlineHospitalSourceCodeWebPerson_SourceCodeID_dbo_SourceCode_SourceCodeID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]'))
ALTER TABLE [dbo].[OnlineHospitalSourceCodeWebPerson]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID] FOREIGN KEY([webPersonID])
REFERENCES [dbo].[WebPerson] ([WebPersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalSourceCodeWebPerson]'))
ALTER TABLE [dbo].[OnlineHospitalSourceCodeWebPerson] CHECK CONSTRAINT [FK_dbo_OnlineHospitalSourceCodeWebPerson_webPersonID_dbo_WebPerson_WebPersonID]
GO
