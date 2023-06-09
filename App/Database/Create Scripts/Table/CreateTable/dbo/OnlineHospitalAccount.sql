SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OnlineHospitalAccount](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[WebPersonID] [int] NULL,
	[GroupOwnerID] [int] NULL,
	[ReportGroupID] [int] NULL,
	[HospitalID] [int] NULL,
	[DefaultSourceCodeID] [int] NULL,
	[PersonID] [int] NULL,
 CONSTRAINT [PK_OnlineHospitalAccount] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]') AND name = N'PK_WebPerson')
CREATE UNIQUE CLUSTERED INDEX [PK_WebPerson] ON [dbo].[OnlineHospitalAccount]
(
	[WebPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]'))
ALTER TABLE [dbo].[OnlineHospitalAccount]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]'))
ALTER TABLE [dbo].[OnlineHospitalAccount] CHECK CONSTRAINT [FK_dbo_OnlineHospitalAccount_PersonID_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]'))
ALTER TABLE [dbo].[OnlineHospitalAccount]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID] FOREIGN KEY([WebPersonID])
REFERENCES [dbo].[WebPerson] ([WebPersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OnlineHospitalAccount]'))
ALTER TABLE [dbo].[OnlineHospitalAccount] CHECK CONSTRAINT [FK_dbo_OnlineHospitalAccount_WebPersonID_dbo_WebPerson_WebPersonID]
GO
