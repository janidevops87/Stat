if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[_UpdateStatsLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[_UpdateStatsLog]
GO

CREATE TABLE [dbo].[_UpdateStatsLog] (
	[UpdateStatsLogID] [int] IDENTITY (1, 1) NOT NULL ,
	[UpdateStatsLogSP] [char] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[UpdateStatsLogStart] [datetime] NOT NULL ,
	[UpdateStatsLogEnd] [datetime] NULL ,
	[UpdateStatsLogResults] [smallint] NOT NULL ,
	[UpdateStatsLogDuration] [varchar] (8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdateStatsLogMYList] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdateStatsLogNumMonths] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


