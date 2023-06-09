SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TcssRecipient]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[TcssRecipient](
	[TcssRecipientId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LastUpdateStatEmployeeId] [int] NOT NULL,
	[LastUpdateDate] [datetime] NOT NULL,
 CONSTRAINT [PK_TcssRecipient] PRIMARY KEY CLUSTERED 
(
	[TcssRecipientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_TcssRecipient_LastUpdateDate]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[TcssRecipient] ADD  CONSTRAINT [DF_TcssRecipient_LastUpdateDate]  DEFAULT (getutcdate()) FOR [LastUpdateDate]
END
GO
