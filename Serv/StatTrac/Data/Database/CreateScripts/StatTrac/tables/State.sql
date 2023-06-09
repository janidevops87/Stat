if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[State]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[State]
GO

CREATE TABLE [dbo].[State] (
	[StateID] [int] IDENTITY (1, 1) NOT NULL ,
	[StateAbbrv] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


