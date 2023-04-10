if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ServiceLevelSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ServiceLevelSourceCode]
GO

CREATE TABLE [dbo].[ServiceLevelSourceCode] (
	[ServiceLevelSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[ServiceLevelID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[Unused] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


