SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Appropriate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Appropriate](
	[AppropriateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AppropriateName] [varchar](50) NULL,
	[AppropriateReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[AppropriateReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[AppropriateReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_Appropriate_1__13] PRIMARY KEY CLUSTERED 
(
	[AppropriateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
