SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatFileOrgFrequency]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatFileOrgFrequency](
	[OrgID] [int] NOT NULL,
	[FrequencyID] [int] NOT NULL,
	[RecordsReturned] [int] NOT NULL
) ON [PRIMARY]
END
GO
