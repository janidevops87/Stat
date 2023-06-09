SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatFileFrequency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatFileFrequency](
	[FrequencyID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Quantity] [int] NOT NULL,
	[Units] [int] NOT NULL,
	[Display] [varchar](20) NOT NULL
) ON [PRIMARY]
END
GO
