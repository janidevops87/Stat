if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[PersonLog]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[PersonLog]
GO

CREATE TABLE [dbo].[PersonLog] (
	[PersonLogId] [int] IDENTITY (1, 1) NOT NULL ,
	[PersonID] [int] NULL ,
	[PersonFirst] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonMI] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonLast] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonTypeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL 
) ON [PRIMARY]
GO


