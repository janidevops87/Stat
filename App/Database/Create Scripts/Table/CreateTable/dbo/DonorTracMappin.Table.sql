SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracMappingTable]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracMappingTable](
	[DonorCategory] [varchar](50) NULL,
	[CriteriaGroup] [varchar](100) NULL,
	[CategoryMapping] [varchar](50) NULL,
	[DonorTracCategory] [varchar](50) NULL,
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL
) ON [PRIMARY]
END
GO
