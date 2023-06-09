if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Approach]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Approach]
GO

CREATE TABLE [dbo].[Approach] (
	[ApproachID] [int] IDENTITY (1, 1) NOT NULL ,
	[ApproachName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[ApproachReportName] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[ApproachReportDisplaySort1] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[ApproachReportCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


