if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DonorTracCategory]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DonorTracCategory]
GO

CREATE TABLE [dbo].[DonorTracCategory] (
	[DonorCategoryID] [int] IDENTITY (1, 1) NOT NULL ,
	[DonorCategoryName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


