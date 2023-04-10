if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TimeSegment]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[TimeSegment]
GO

CREATE TABLE [dbo].[TimeSegment] (
	[TimeSegmentID] [int] IDENTITY (1, 1) NOT NULL ,
	[TimeSegmentName] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


