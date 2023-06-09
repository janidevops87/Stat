SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TimeSheet]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TimeSheet](
	[TimeSheetID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[TimeSheetEmployeeID] [int] NULL,
	[TimeSheetDate] [datetime] NULL,
	[TimeSheetType] [int] NULL,
	[TimeSheetValue] [int] NULL,
	[TimeSheetComment] [varchar](50) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeSheetID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
