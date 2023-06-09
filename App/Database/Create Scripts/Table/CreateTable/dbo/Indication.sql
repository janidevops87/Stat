SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Indication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Indication](
	[IndicationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[IndicationName] [varchar](80) NULL,
	[IndicationNote] [varchar](255) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[IndicationHighRisk] [smallint] NULL,
	[UpdatedFlag] [smallint] NULL,
	[IndicationResponseID] [int] NULL,
	[IndicationResponseName] [nvarchar](50) NULL,
	[IndicationQuestionAssociatedID] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_Indication_1__13] PRIMARY KEY CLUSTERED 
(
	[IndicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Indication]') AND name = N'IndicationName')
CREATE NONCLUSTERED INDEX [IndicationName] ON [dbo].[Indication]
(
	[IndicationName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [IDX]
GO
