SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DesignatedRequestors_ORG]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DesignatedRequestors_ORG](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ORG] [varchar](255) NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar](255) NULL,
 CONSTRAINT [PK_DesignatedRequestors_ORG] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DesignatedRequestors_ORG]'))
ALTER TABLE [dbo].[DesignatedRequestors_ORG]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DesignatedRequestors_ORG]'))
ALTER TABLE [dbo].[DesignatedRequestors_ORG] CHECK CONSTRAINT [FK_dbo_DesignatedRequestors_ORG_OrganizationID_dbo_Organization_OrganizationID]
GO
