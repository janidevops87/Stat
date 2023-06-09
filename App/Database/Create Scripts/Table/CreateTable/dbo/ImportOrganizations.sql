SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ImportOrganizations](
	[Name] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[OPO] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[SpecialInstructions] [nvarchar](255) NULL,
	[stateid] [int] NULL,
	[OrganizationId] [int] NULL,
	[Countyid] [int] NULL,
	[zipcode] [int] NULL,
	[phoneid] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationId])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations] CHECK CONSTRAINT [FK_dbo_ImportOrganizations_OrganizationId_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID] FOREIGN KEY([phoneid])
REFERENCES [dbo].[Phone] ([PhoneID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations] CHECK CONSTRAINT [FK_dbo_ImportOrganizations_phoneid_dbo_Phone_PhoneID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_stateid_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_ImportOrganizations_stateid_dbo_State_StateID] FOREIGN KEY([stateid])
REFERENCES [dbo].[State] ([StateID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_ImportOrganizations_stateid_dbo_State_StateID]') AND parent_object_id = OBJECT_ID(N'[dbo].[ImportOrganizations]'))
ALTER TABLE [dbo].[ImportOrganizations] CHECK CONSTRAINT [FK_dbo_ImportOrganizations_stateid_dbo_State_StateID]
GO
