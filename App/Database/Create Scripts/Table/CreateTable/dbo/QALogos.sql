SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QALogos]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QALogos](
	[LogoId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LogoName] [char](100) NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[TrackingTypeID] [int] NOT NULL,
	[ImageName] [varchar](50) NULL,
 CONSTRAINT [PK_QALogos] PRIMARY KEY CLUSTERED 
(
	[LogoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QALogos]'))
ALTER TABLE [dbo].[QALogos]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[QALogos]'))
ALTER TABLE [dbo].[QALogos] CHECK CONSTRAINT [FK_dbo_QALogos_OrganizationID_dbo_Organization_OrganizationID]
GO
