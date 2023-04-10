if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[BloodProduct]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[BloodProduct]
GO

CREATE TABLE [dbo].[BloodProduct] (
	[BloodProductId] [int] IDENTITY (1, 1) NOT NULL ,
	[BloodProductName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[BloodProductType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


