if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSApproach]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSApproach]
GO

CREATE TABLE [dbo].[FSApproach] (
	[FSApproachID] [int] NOT NULL ,
	[FSApproachName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[FSApproachReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[FSApproachReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[FSApproachReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


