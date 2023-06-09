if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[RotationSourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[RotationSourceCode]
GO

CREATE TABLE [dbo].[RotationSourceCode] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[RotationGroupID] [int] NULL ,
	[RotationID] [int] NULL ,
	[RotationSourceCodeID] [int] NULL ,
	[RotationSourcecodeName] [char] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RotationSourceCodeType] [int] NULL 
) ON [PRIMARY]
GO


