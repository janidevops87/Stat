if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[YesNoNa_Ref]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[YesNoNa_Ref]
GO

CREATE TABLE [dbo].[YesNoNa_Ref] (
	[YesNoNa_RefId] [int] IDENTITY (0, 1) NOT NULL ,
	[YesNoNa_RefName] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


