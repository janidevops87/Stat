if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaSourceCode]
GO

CREATE TABLE [dbo].[CriteriaSourceCode] (
	[CriteriaSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


