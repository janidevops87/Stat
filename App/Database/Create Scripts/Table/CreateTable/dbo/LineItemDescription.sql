SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LineItemDescription]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[LineItemDescription](
	[LineItemDescriptionID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LineItemDescriptionName] [varchar](250) NOT NULL,
	[LineItemPrice] [decimal](9, 2) NOT NULL,
	[LineItemProductID] [varchar](50) NULL,
	[LineItemDescriptionReconcile] [bit] NULL,
 CONSTRAINT [PK_LineItemDescription] PRIMARY KEY NONCLUSTERED 
(
	[LineItemDescriptionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_LineItemDescription_LineItemDescriptionReconcile]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[LineItemDescription] ADD  CONSTRAINT [DF_LineItemDescription_LineItemDescriptionReconcile]  DEFAULT (1) FOR [LineItemDescriptionReconcile]
END
GO
