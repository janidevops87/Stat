SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[GeneralConsentType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[GeneralConsentType](
	[GeneralConsentTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[GeneralConsentTypeName] [varchar](50) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL
) ON [PRIMARY]
END
GO
