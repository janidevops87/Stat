SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reference_Map]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Reference_Map](
	[ReferenceMapId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ReferenceMapName] [varchar](100) NOT NULL,
	[ReferenceMapTypeId] [int] NOT NULL,
	[RM_SourceTable] [varchar](100) NULL,
	[RM_SourceColumn] [varchar](100) NULL,
	[RM_SourceDataType] [varchar](50) NULL,
	[RM_DestTable] [varchar](100) NULL,
	[RM_DestColumn] [varchar](100) NULL,
	[RM_DestDataType] [varchar](50) NULL,
	[RM_SourceIntValue] [int] NOT NULL,
	[RM_DestIntValue] [int] NOT NULL,
	[RM_SourceTextValue] [varchar](250) NULL,
	[RM_DestTextValue] [varchar](250) NULL,
	[RM_SourceDateValue] [datetime] NULL,
	[RM_DestDateValue] [datetime] NULL,
 CONSTRAINT [PK_Reference_Map] PRIMARY KEY NONCLUSTERED 
(
	[ReferenceMapId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
