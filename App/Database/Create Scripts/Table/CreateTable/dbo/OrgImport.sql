SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrgImport]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrgImport](
	[orgimportid] [int] NOT NULL,
	[CountyName] [nvarchar](255) NULL,
	[OrganizationName] [nvarchar](255) NULL,
	[Address1] [nvarchar](255) NULL,
	[Address2] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[State] [nvarchar](255) NULL,
	[Zip] [nvarchar](255) NULL,
	[AreaCode] [nvarchar](255) NULL,
	[Prefix] [nvarchar](255) NULL,
	[DNIT] [nvarchar](255) NULL,
	[Column] [float] NULL,
	[Order] [float] NULL,
	[City, State, Zip] [nvarchar](255) NULL,
	[Phone number] [nvarchar](255) NULL
) ON [PRIMARY]
END
GO
