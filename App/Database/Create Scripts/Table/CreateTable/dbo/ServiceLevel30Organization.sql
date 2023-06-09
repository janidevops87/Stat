SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel30Organization]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevel30Organization](
	[ServiceLevelOrganizationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ServiceLevelID] [int] NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_ServiceLevel30Organiza1__13] PRIMARY KEY CLUSTERED 
(
	[ServiceLevelOrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel30Organization]') AND name = N'OrganizationID')
CREATE NONCLUSTERED INDEX [OrganizationID] ON [dbo].[ServiceLevel30Organization]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevel30Organization]') AND name = N'ServiceLevelID')
CREATE NONCLUSTERED INDEX [ServiceLevelID] ON [dbo].[ServiceLevel30Organization]
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevel30Organization]'))
ALTER TABLE [dbo].[ServiceLevel30Organization]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ServiceLevel30Organization]'))
ALTER TABLE [dbo].[ServiceLevel30Organization] CHECK CONSTRAINT [FK_dbo_ServiceLevel30Organization_OrganizationID_dbo_Organization_OrganizationID]
GO
