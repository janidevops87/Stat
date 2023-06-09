if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Reference_Map]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Reference_Map]
GO

CREATE TABLE [dbo].[Reference_Map] (
	[ReferenceMapId] [int] IDENTITY (1, 1) NOT NULL ,
	[ReferenceMapName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[ReferenceMapTypeId] [int] NOT NULL ,
	[RM_SourceTable] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_SourceColumn] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_SourceDataType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_DestTable] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_DestColumn] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_DestDataType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_SourceIntValue] [int] NOT NULL ,
	[RM_DestIntValue] [int] NOT NULL ,
	[RM_SourceTextValue] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_DestTextValue] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[RM_SourceDateValue] [datetime] NULL ,
	[RM_DestDateValue] [datetime] NULL 
) ON [PRIMARY]
GO


