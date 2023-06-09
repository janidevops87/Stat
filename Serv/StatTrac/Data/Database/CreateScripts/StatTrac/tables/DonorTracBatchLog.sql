if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DonorTracBatchLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[DonorTracBatchLog]
GO

CREATE TABLE [dbo].[DonorTracBatchLog] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[SourceCodeID] [int] NULL ,
	[SourceCodeName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StartTime] [datetime] NULL ,
	[EndTime] [datetime] NULL ,
	[RunTime] [datetime] NULL 
) ON [PRIMARY]
GO


