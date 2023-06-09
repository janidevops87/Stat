SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Approach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Approach](
	[ApproachID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ApproachName] [varchar](50) NULL,
	[ApproachReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[ApproachReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[ApproachReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_Approach_1__13] PRIMARY KEY CLUSTERED 
(
	[ApproachID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
