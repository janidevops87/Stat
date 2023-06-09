SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallBack]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallBack](
	[CallBackID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[PhoneID] [int] NULL,
	[OrganizationID] [int] NULL,
	[LastModified] [datetime] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallBack]'))
ALTER TABLE [dbo].[CallBack]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallBack]'))
ALTER TABLE [dbo].[CallBack] CHECK CONSTRAINT [FK_dbo_CallBack_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallBack]'))
ALTER TABLE [dbo].[CallBack]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID] FOREIGN KEY([PhoneID])
REFERENCES [dbo].[Phone] ([PhoneID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallBack]'))
ALTER TABLE [dbo].[CallBack] CHECK CONSTRAINT [FK_dbo_CallBack_PhoneID_dbo_Phone_PhoneID]
GO
