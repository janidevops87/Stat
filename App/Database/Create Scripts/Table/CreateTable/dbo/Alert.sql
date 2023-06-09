SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Alert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Alert](
	[AlertID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AlertGroupName] [varchar](80) NULL,
	[AlertMessage1] [ntext] NULL,
	[AlertMessage2] [ntext] NULL,
	[LastModified] [datetime] NULL,
	[AlertTypeID] [int] NULL,
	[AlertLookupCode] [varchar](8) NULL,
	[AlertScheduleMessage] [ntext] NULL,
	[UpdatedFlag] [smallint] NULL,
	[AlertQAMessage1] [ntext] NULL,
	[AlertQAMessage2] [ntext] NULL,
 CONSTRAINT [PK_Alert_1__10] PRIMARY KEY CLUSTERED 
(
	[AlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Alert]') AND name = N'AlertTypeID')
CREATE NONCLUSTERED INDEX [AlertTypeID] ON [dbo].[Alert]
(
	[AlertTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
