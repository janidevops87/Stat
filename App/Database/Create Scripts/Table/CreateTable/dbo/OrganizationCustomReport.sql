SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrganizationCustomReport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrganizationCustomReport](
	[OrganizationCustomReportID] [int] NULL,
	[OrganizationID] [int] NOT NULL,
	[LastModified] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_OrganizationCustomReport_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationCustomReport] ADD  CONSTRAINT [DF_OrganizationCustomReport_LastModified]  DEFAULT (sysdatetime()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationCustomReport]'))
ALTER TABLE [dbo].[OrganizationCustomReport]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrganizationCustomReport]'))
ALTER TABLE [dbo].[OrganizationCustomReport] CHECK CONSTRAINT [FK_dbo_OrganizationCustomReport_OrganizationID_dbo_Organization_OrganizationID]
GO
