SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ReportParamSection]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ReportParamSection](
	[ReportParamSectionID] [int] NOT NULL,
	[ReportParamSectionName] [varchar](25) NULL,
 CONSTRAINT [PK_ReportParamSection] PRIMARY KEY CLUSTERED 
(
	[ReportParamSectionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
