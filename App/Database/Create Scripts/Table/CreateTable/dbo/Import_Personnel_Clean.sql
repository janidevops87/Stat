SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Import_Personnel_Clean]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Import_Personnel_Clean](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Import_Personnel_Log_ID] [int] NULL,
	[Source_Code_ID] [int] NULL,
	[Organization_ID] [int] NULL,
	[First_Name] [varchar](50) NULL,
	[Middle_Name] [varchar](1) NULL,
	[Last_Name] [varchar](50) NULL,
	[Person_Type_ID] [int] NULL,
	[Home_Phone] [varchar](16) NULL,
	[Work_Phone] [varchar](16) NULL,
	[Cell_Phone] [varchar](16) NULL,
	[Alpha_Pager] [varchar](16) NULL,
	[Alpha_Pager_Email_Address] [varchar](100) NULL,
	[Verified] [bit] NULL,
	[Allow_Internet_Schedule_Access] [bit] NULL,
	[Person_Security] [int] NULL,
 CONSTRAINT [PK_Import_Personnel_Clean] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
