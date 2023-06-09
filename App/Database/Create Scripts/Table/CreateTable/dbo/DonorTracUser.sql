SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracUser]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracUser](
	[DonorTracUserID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NULL,
	[DonorTracUserGUID] [uniqueidentifier] NULL,
	[StatEmployeeID] [int] NULL,
	[LastModified] [datetime] NULL,
	[DonorTracDBID] [int] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID] FOREIGN KEY([DonorTracDBID])
REFERENCES [dbo].[DonorTracDB] ([DonorTracDBID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser] CHECK CONSTRAINT [FK_dbo_DonorTracUser_DonorTracDBID_dbo_DonorTracDB_DonorTracDBID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser] CHECK CONSTRAINT [FK_dbo_DonorTracUser_OrganizationID_dbo_Organization_OrganizationID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID] FOREIGN KEY([StatEmployeeID])
REFERENCES [dbo].[StatEmployee] ([StatEmployeeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracUser]'))
ALTER TABLE [dbo].[DonorTracUser] CHECK CONSTRAINT [FK_dbo_DonorTracUser_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]
GO
