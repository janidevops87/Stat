SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracDB]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracDB](
	[DonorTracDBID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[DonorTracDBName] [varchar](50) NULL,
	[DonorTracOrganizationGUID] [uniqueidentifier] NULL,
	[DonorTracUpdate] [bit] NULL,
 CONSTRAINT [PK_DonorTracDB] PRIMARY KEY CLUSTERED 
(
	[DonorTracDBID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracDB]') AND name = N'IX_DonorTracDB')
CREATE NONCLUSTERED INDEX [IX_DonorTracDB] ON [dbo].[DonorTracDB]
(
	[OrganizationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracDB]'))
ALTER TABLE [dbo].[DonorTracDB]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracDB]'))
ALTER TABLE [dbo].[DonorTracDB] CHECK CONSTRAINT [FK_dbo_DonorTracDB_OrganizationID_dbo_Organization_OrganizationID]
GO
