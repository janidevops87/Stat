SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSAppropriate]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSAppropriate](
	[FSAppropriateID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FSAppropriateName] [varchar](50) NULL,
	[FSAppropriateReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[FSAppropriateReportDisplaySort1] [int] NULL,
	[LastModified] [smalldatetime] NULL,
	[AppropriateReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_FSAppropriate] PRIMARY KEY NONCLUSTERED 
(
	[FSAppropriateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
