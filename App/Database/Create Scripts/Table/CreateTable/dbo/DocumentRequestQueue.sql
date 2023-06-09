SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DocumentRequestQueue]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DocumentRequestQueue](
	[DocumentRequestQueueId] [int] IDENTITY(1,1) NOT NULL,
	[CallId] [int] NULL,
	[DocumentSentById] [int] NULL,
	[DocumentTo] [varchar](50) NULL,
	[DocumentOrganization] [varchar](50) NULL,
	[DocumentOrganizationId] [int] NULL,
	[FaxNumber] [varchar](11) NULL,
	[Email] [varchar](100) NULL,
	[SubmitDate] [datetime] NULL,
	[SentDate] [datetime] NULL,
	[JobId] [varchar](25) NULL,
	[ConfirmedDate] [datetime] NULL,
	[DeleteDate] [datetime] NULL,
	[DmvTable] [varchar](50) NULL,
	[DmvId] [int] NULL,
	[RegId] [int] NULL,
	[FormName] [varchar](50) NULL,
	[UserID] [int] NULL,
	[LastModified] [datetime] NULL,
	[DSNID] [smallint] NULL
) ON [PRIMARY]
END
GO
