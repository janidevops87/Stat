SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Organization_Clean]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Organization_Clean](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Organization_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Facility_Name] [varchar](80) NULL,
	[Address1] [varchar](80) NULL,
	[Address2] [varchar](80) NULL,
	[City] [varchar](30) NULL,
	[State_ID] [int] NULL,
	[Zip_Code] [varchar](6) NULL,
	[County_ID] [int] NULL,
	[Facility_Type_ID] [int] NULL,
	[Phone_ID] [int] NULL,
	[Fax_Number] [varchar](13) NULL,
	[Time_Zone] [varchar](2) NULL,
	[Hospital_Code] [varchar](10) NULL
) ON [PRIMARY]
END
GO
