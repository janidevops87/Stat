SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Personnel_Suspense]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Personnel_Suspense](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Personnel_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Organization_ID] [int] NULL,
	[First_Name] [varchar](50) NULL,
	[Middle_Name] [varchar](1) NULL,
	[Last_Name] [varchar](50) NULL,
	[Person_Type_ID] [int] NULL,
	[Home_Phone] [varchar](13) NULL,
	[Work_Phone] [varchar](13) NULL,
	[Cell_Phone] [varchar](13) NULL,
	[Alpha_Pager] [varchar](13) NULL,
	[Alpha_Pager_Email_Address] [varchar](100) NULL,
	[Verified] [bit] NULL,
	[Allow_Internet_Schedule_Access] [bit] NULL,
	[Person_Security] [int] NULL
) ON [PRIMARY]
END
GO
