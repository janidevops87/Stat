SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ExportFileFrequency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ExportFileFrequency](
	[ExportFileFrequencyID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ExportFileFrequencyName] [nvarchar](50) NULL,
 CONSTRAINT [PK_ExportFileFrequency] PRIMARY KEY CLUSTERED 
(
	[ExportFileFrequencyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
