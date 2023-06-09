if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DonorTracMappingTable]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DonorTracMappingTable]
GO

CREATE TABLE [dbo].[DonorTracMappingTable] (
	[DonorCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CriteriaGroup] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CategoryMapping] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DonorTracCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ID] [int] IDENTITY (1, 1) NOT NULL 
) ON [PRIMARY]
GO


