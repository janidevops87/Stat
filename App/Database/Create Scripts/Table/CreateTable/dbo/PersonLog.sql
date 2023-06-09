SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PersonLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[PersonLog](
	[PersonLogId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PersonID] [int] NULL,
	[PersonFirst] [varchar](50) NULL,
	[PersonMI] [varchar](1) NULL,
	[PersonLast] [varchar](50) NULL,
	[PersonTypeID] [int] NULL,
	[OrganizationID] [int] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_PersonLog] PRIMARY KEY NONCLUSTERED 
(
	[PersonLogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog] CHECK CONSTRAINT [FK_dbo_PersonLog_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_PersonLog_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog] CHECK CONSTRAINT [FK_dbo_PersonLog_PersonID_dbo_Person_PersonID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID] FOREIGN KEY([PersonTypeID])
REFERENCES [dbo].[PersonType] ([PersonTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[PersonLog]'))
ALTER TABLE [dbo].[PersonLog] CHECK CONSTRAINT [FK_dbo_PersonLog_PersonTypeID_dbo_PersonType_PersonTypeID]
GO
