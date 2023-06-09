SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DonorTracCategory]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DonorTracCategory](
	[DonorCategoryID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DonorCategoryName] [varchar](50) NOT NULL,
	[verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracCategory]'))
ALTER TABLE [dbo].[DonorTracCategory]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID] FOREIGN KEY([DonorCategoryID])
REFERENCES [dbo].[DonorCategory] ([DonorCategoryID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]') AND parent_object_id = OBJECT_ID(N'[dbo].[DonorTracCategory]'))
ALTER TABLE [dbo].[DonorTracCategory] CHECK CONSTRAINT [FK_dbo_DonorTracCategory_DonorCategoryID_dbo_DonorCategory_DonorCategoryID]
GO
