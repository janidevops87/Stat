/****** Object:  Table [dbo].[Import_Adds]    Script Date: 10/27/2016 10:55:51 PM ******/
SET ANSI_NULLS ON;
GO

SET QUOTED_IDENTIFIER ON;
GO

SET ANSI_PADDING ON;
GO

IF EXISTS (SELECT * FROM [dbo].[sysobjects] WHERE id = object_id(N'[dbo].[Import_Adds]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
	DROP TABLE [dbo].[Import_Adds];

CREATE TABLE [dbo].[Import_Adds](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportLogId] [int] NULL,
	[Last] [varchar](40) NULL,
	[First] [varchar](40) NULL,
	[Middle] [varchar](20) NULL,
	[Suffix] [varchar](4) NULL,
	[AAddr1] [varchar](80) NULL,
	[ACity] [varchar](80) NULL,
	[AState] [varchar](2) NULL,
	[AZip] [varchar](5) NULL,
	[AZipExt] [varchar](4) NULL,
	[BAddr1] [varchar](80) NULL,
	[BCity] [varchar](80) NULL,
	[BState] [varchar](2) NULL,
	[BZip] [varchar](5) NULL,
	[DOB] [varchar](10) NULL,
	[Gender] [varchar](1) NULL,
	[License] [varchar](20) NULL,
	[IssueDate] [varchar](8) NULL,
	[ExpirationDate] [varbinary](8) NULL,
	[Donor] [varchar](2) NULL,
	[SignupDate] [varchar](8) NULL,
	[RenewalDate] [varchar](8) NULL,
	[DeceasedDate] [varchar](8) NULL,
	[CSORState] [varchar](8) NULL,
	[CSORLicense] [varchar](8) NULL,
	[CreateDate] [smalldatetime] NULL CONSTRAINT [DF_Import_Adds_CreateDate] DEFAULT (GETDATE())
) ON [PRIMARY];
GO

CREATE NONCLUSTERED INDEX [iDx_Import_Adds_ID_includes]
	ON [dbo].[Import_Adds] ([ID] ASC)
	WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [IDX];
GO

SET ANSI_PADDING OFF;
GO
