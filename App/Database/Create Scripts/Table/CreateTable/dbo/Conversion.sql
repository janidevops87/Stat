SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Conversion]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Conversion](
	[ConversionID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ConversionName] [varchar](50) NULL,
	[ConversionReportName] [varchar](9) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[ConversionReportDisplaySort1] [int] NULL,
	[LastModified] [datetime] NULL,
	[ConversionReportCode] [varchar](3) NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_Conversion_1__13] PRIMARY KEY CLUSTERED 
(
	[ConversionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
