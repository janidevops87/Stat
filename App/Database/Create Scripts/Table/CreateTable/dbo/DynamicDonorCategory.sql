SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DynamicDonorCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DynamicDonorCategory](
	[DynamicDonorCategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DynamicDonorCategoryName] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_DynamicDonorCategory] PRIMARY KEY CLUSTERED 
(
	[DynamicDonorCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
