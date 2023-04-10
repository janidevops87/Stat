if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaSubType]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaSubType]
GO

CREATE TABLE [dbo].[CriteriaSubType] (
	[CriteriaSubTypeID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NOT NULL ,
	[SubTypeID] [int] NOT NULL ,
	[SubCriteriaPrecedence] [int] NULL 
) ON [PRIMARY]
GO


