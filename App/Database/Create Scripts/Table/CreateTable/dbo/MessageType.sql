SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[MessageType]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[MessageType](
	[MessageTypeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[MessageTypeName] [varchar](50) NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_MessageType_1__13] PRIMARY KEY CLUSTERED 
(
	[MessageTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
