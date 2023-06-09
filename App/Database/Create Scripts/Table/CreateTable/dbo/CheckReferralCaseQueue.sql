SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CheckReferralCaseQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CheckReferralCaseQueue](
	[CheckReferralCaseQueueID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[LastModified] [datetime] NULL,
	[ExportFileID] [int] NULL
) ON [PRIMARY]
END
GO
