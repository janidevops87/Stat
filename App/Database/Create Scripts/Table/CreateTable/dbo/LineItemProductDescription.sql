SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ LineItemProductDescription]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ LineItemProductDescription](
	[LineItemProductDescriptionID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[LineItemProductDescription] [varchar](25) NULL,
	[LineItemDescriptionHistoryProductID] [int] NULL
) ON [PRIMARY]
END
GO
