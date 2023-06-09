SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fax]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Fax](
	[FaxId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FaxNumber] [char](14) NOT NULL,
	[OrganizationId] [int] NOT NULL,
 CONSTRAINT [PK_Fax] PRIMARY KEY NONCLUSTERED 
(
	[FaxId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Fax]'))
ALTER TABLE [dbo].[Fax]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[Fax]'))
ALTER TABLE [dbo].[Fax] CHECK CONSTRAINT [FK_dbo_Fax_OrganizationId_dbo_Organization_OrganizationID]
GO
