SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSIndication]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSIndication](
	[FSIndicationID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FSIndicationName] [varchar](255) NULL,
 CONSTRAINT [PK_FSIndication] PRIMARY KEY NONCLUSTERED 
(
	[FSIndicationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
