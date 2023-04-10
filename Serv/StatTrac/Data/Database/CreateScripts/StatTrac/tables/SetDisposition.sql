if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SetDisposition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SetDisposition]
GO

CREATE TABLE [dbo].[SetDisposition] (
	[SetDispositionID] [int] NOT NULL ,
	[DispositionID] [int] NULL ,
	[OptionID] [int] NULL ,
	[AppropriateID] [int] NULL ,
	[ApproachID] [int] NULL ,
	[ConsentID] [int] NULL ,
	[RecoveryID] [int] NULL 
) ON [PRIMARY]
GO


