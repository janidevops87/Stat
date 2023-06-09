if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DynamicDonorCategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DynamicDonorCategory]
GO

CREATE TABLE [dbo].[DynamicDonorCategory] (
	[DynamicDonorCategoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[DynamicDonorCategoryName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


