/* CA DMV Table creation */
if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[DMV]') and OBJECTPROPERTY(id, N'IsTable') = 1)
Begin
	PRINT 'Dropping DMV Table'
	drop table [dbo].[DMV]
End
GO
	PRINT 'Creating DMV Table'
GO


CREATE TABLE [DMV] (
	[ID] [int],
	[DMVIMPORTLOGID] [int] NULL ,
	[CAID] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SSN] [varchar] (11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[License] [varchar] (9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DOB] [datetime] NULL ,
	[FirstName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MiddleName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[LastName] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Suffix] [varchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Gender] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Donor] [bit] NOT NULL,
	[CountyCode] [varchar] (3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ImportDate] [datetime] NULL ,
	[RenewalDate] [datetime] NULL ,
	[DeceasedDate] [datetime] NULL ,
	[CSORState] [varchar] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[CSORLicense] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UserID] [int] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	[FULLNAME] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	CONSTRAINT [PK_DMV] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	) WITH  FILLFACTOR = 90  ON [IDX] 
) ON [PRIMARY]
GO
