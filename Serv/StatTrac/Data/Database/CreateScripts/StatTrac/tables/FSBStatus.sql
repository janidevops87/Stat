if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBStatus]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSBStatus]
GO

CREATE TABLE [dbo].[FSBStatus] (
	[FSBStatusId] [int] IDENTITY (1, 1) NOT NULL ,
	[FSBStatusName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FSBCaseTypeId] [int] NOT NULL ,
	[Color] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ThresholdMinutes] [smallint] NOT NULL ,
	[InsertedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[UpdatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateInserted] [datetime] NOT NULL ,
	[DateUpdated] [datetime] NOT NULL 
) ON [PRIMARY]
GO


