SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Organization_Suspense]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Organization_Suspense](
	[ID] [int] NOT NULL,
	[Import_Organization_Log_ID] [int] NULL,
	[Source_Code] [varchar](255) NULL,
	[Facility_Name] [varchar](255) NULL,
	[Address1] [varchar](255) NULL,
	[Address2] [varchar](255) NULL,
	[City] [varchar](255) NULL,
	[State] [varchar](255) NULL,
	[Zip_Code] [varchar](255) NULL,
	[County] [varchar](255) NULL,
	[Facility_Type] [varchar](255) NULL,
	[Central_Phone_Number] [varchar](255) NULL,
	[Fax_Number] [varchar](255) NULL,
	[Time_Zone] [varchar](255) NULL,
	[Hospital_Code] [varchar](255) NULL
) ON [PRIMARY]
END
GO
