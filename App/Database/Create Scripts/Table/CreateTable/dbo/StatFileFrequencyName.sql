SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatFileFrequencyName]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatFileFrequencyName](
	[FrequencyID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Frequencynum] [int] NULL,
	[FrequencyName] [varchar](50) NULL
) ON [PRIMARY]
END
GO
