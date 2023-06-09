SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[RotationOrganizations]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[RotationOrganizations](
	[RotationID] [int] NULL,
	[OrganizationID] [int] NULL,
	[OrganizationName] [varchar](50) NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[RotationOrganizations]') AND name = N'IX_RotationId')
CREATE NONCLUSTERED INDEX [IX_RotationId] ON [dbo].[RotationOrganizations]
(
	[RotationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
