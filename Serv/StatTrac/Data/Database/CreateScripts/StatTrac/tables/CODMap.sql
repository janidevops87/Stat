if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CODMap]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CODMap]
GO

CREATE TABLE [dbo].[CODMap] (
	[MapID] [int] IDENTITY (1, 1) NOT NULL ,
	[CountyID] [int] NULL ,
	[StateID] [int] NULL ,
	[CountyFIPS] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CoalitionID] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[OrganizationID] [int] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


