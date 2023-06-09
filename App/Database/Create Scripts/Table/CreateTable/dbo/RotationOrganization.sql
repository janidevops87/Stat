SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationOrganization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationOrganization](
	[RotationGroupID] [char](10) NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar](255) NULL,
	[OrganizationCity] [varchar](255) NULL,
	[OrganizationState] [int] NULL,
	[OrganizationType] [int] NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationOrganization]') AND name = N'IX_RotationGroupId')
CREATE NONCLUSTERED INDEX [IX_RotationGroupId] ON [dbo].[RotationOrganization]
(
	[RotationGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[RotationOrganization]'))
ALTER TABLE [dbo].[RotationOrganization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[RotationOrganization]'))
ALTER TABLE [dbo].[RotationOrganization] CHECK CONSTRAINT [FK_dbo_RotationOrganization_OrganizationID_dbo_Organization_OrganizationID]
GO
