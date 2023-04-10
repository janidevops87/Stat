if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AlertSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AlertSourceCode]
GO

CREATE TABLE [dbo].[AlertSourceCode] (
	[AlertSourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[AlertID] [int] NULL ,
	[SourceCodeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


