SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[AlertOrganization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[AlertOrganization](
	[AlertOrganizationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AlertID] [int] NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_AlertOrganization_1__13] PRIMARY KEY NONCLUSTERED 
(
	[AlertOrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AlertOrganization]') AND name = N'AlertID')
CREATE NONCLUSTERED INDEX [AlertID] ON [dbo].[AlertOrganization]
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[AlertOrganization]') AND name = N'OrgID')
CREATE NONCLUSTERED INDEX [OrgID] ON [dbo].[AlertOrganization]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertOrganization]'))
ALTER TABLE [dbo].[AlertOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID] FOREIGN KEY([AlertID])
REFERENCES [dbo].[Alert] ([AlertID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertOrganization]'))
ALTER TABLE [dbo].[AlertOrganization] CHECK CONSTRAINT [FK_dbo_AlertOrganization_AlertID_dbo_Alert_AlertID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertOrganization]'))
ALTER TABLE [dbo].[AlertOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[AlertOrganization]'))
ALTER TABLE [dbo].[AlertOrganization] CHECK CONSTRAINT [FK_dbo_AlertOrganization_OrganizationID_dbo_Organization_OrganizationID]
GO
