if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SourceCode]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SourceCode]
GO

CREATE TABLE [dbo].[SourceCode] (
	[SourceCodeID] [int] IDENTITY (1, 1) NOT NULL ,
	[SourceCodeName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCodeDescription] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL ,
	[SourceCodeType] [int] NULL ,
	[SourceCodeDefaultAlert] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCodeLineCheckInstruc] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCodeLineCheckInterval] [int] NULL ,
	[SourceCode1Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode1End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode2Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode2End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode3Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode3End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode4Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode4End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode5Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode5End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode6Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode6End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode7Start] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCode7End] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCodeDisabledInterval] [smallint] NOT NULL ,
	[SourceCodeNameUnAbbrev] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourceCodeRotationActive] [smallint] NULL ,
	[SourcecodeRotationAlias] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SourcecodeRotationTrue] [smallint] NULL ,
	[SourcecodeDonorTracClient] [smallint] NULL 
) ON [PRIMARY]
GO


