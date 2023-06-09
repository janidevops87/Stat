SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GeneralAlert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GeneralAlert](
	[GeneralAlertID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GeneralAlertExpires] [smalldatetime] NULL,
	[GeneralAlertOrg] [varchar](20) NULL,
	[GeneralAlertMessage] [varchar](255) NULL,
	[PersonID] [int] NULL,
	[LastModified] [datetime] NULL,
	[OrganizationID] [int] NULL,
 CONSTRAINT [PK___1__21] PRIMARY KEY CLUSTERED 
(
	[GeneralAlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GeneralAlert]'))
ALTER TABLE [dbo].[GeneralAlert]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GeneralAlert]'))
ALTER TABLE [dbo].[GeneralAlert] CHECK CONSTRAINT [FK_dbo_GeneralAlert_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GeneralAlert]'))
ALTER TABLE [dbo].[GeneralAlert]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[GeneralAlert]'))
ALTER TABLE [dbo].[GeneralAlert] CHECK CONSTRAINT [FK_dbo_GeneralAlert_PersonID_dbo_Person_PersonID]
GO
