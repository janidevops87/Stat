/****** Object:  Table [dbo].[Import_Deletes]    Script Date: 11/14/2016 10:48:49 AM ******/
DROP TABLE [dbo].[Import_Deletes]
GO

/****** Object:  Table [dbo].[Import_Deletes]    Script Date: 11/14/2016 10:48:49 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Import_Deletes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ImportLogId] [int] NULL,
	[Last] [varchar](40) NULL,
	[First] [varchar](40) NULL,
	[Middle] [varchar](20) NULL,
	[Suffix] [varchar](4) NULL,
	[AAddr1] [varchar](80) NULL,
	[ACity] [varchar](80) NULL,
	[AState] [varchar](2) NULL,
	[AZip] [varchar](10) NULL,
	[AZipExt] [varchar](4) NULL,
	[BAddr1] [varchar](80) NULL,
	[BCity] [varchar](80) NULL,
	[BState] [varchar](2) NULL,
	[BZip] [varchar](10) NULL,
	[DOB] [varchar](10) NULL,
	[Gender] [varchar](1) NULL,
	[LicenseType] [varchar](2) NULL,
	[License] [varchar](20) NULL,
	[IssueDate] [varchar](8) NULL,
	[ExpirationDate] [varbinary](8) NULL,
	[Donor] [varchar](2) NULL,
	[Signupdate] [varchar](8) NULL,
	[RenewalDate] [varchar](8) NULL,
	[DeceasedDate] [varchar](8) NULL,
	[CSORState] [varchar](8) NULL,
	[CSORLicense] [varchar](8) NULL,
	[CreateDate] [smalldatetime] NULL
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


