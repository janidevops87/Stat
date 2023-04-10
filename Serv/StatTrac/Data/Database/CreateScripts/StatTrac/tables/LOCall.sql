if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[LOCall]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[LOCall]
GO

CREATE TABLE [dbo].[LOCall] (
	[LOCallID] [int] IDENTITY (1, 1) NOT NULL ,
	[CallID] [int] NOT NULL ,
	[StatEmployeeID] [smallint] NULL ,
	[LOCallTotalTime] [varchar] (15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


