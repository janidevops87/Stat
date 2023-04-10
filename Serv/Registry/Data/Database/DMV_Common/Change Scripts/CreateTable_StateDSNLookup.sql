 IF EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'StateDSNLookup')
	BEGIN
		PRINT 'Dropping Table StateDSNLookup'
		DROP  Table StateDSNLookup
	END
GO

/******************************************************************************
**		File: CreateTable_StateDSNLookup.sql
**		Name: StateDNSLookup
**		Desc: 
**
**              
**
**		Auth: 
**		Date: 
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------		--------				-------------------------------------------
**		03/28/2007		ccarroll				initial
**		04/03/2008		cacrroll				added StateParentOrg, StateDisplayName, Default, Active
*******************************************************************************/

PRINT 'Creating Table EventCategory'
GO

CREATE TABLE [StateDSNLookup] (
	[ID] [int] IDENTITY (1, 1) NOT NULL ,
	[State] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[DSN] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[StateDisplayName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Selected] [bit] NULL ,
	[Inactive] [bit] NULL ,
	[LastModified] [datetime] NULL ,
	[CreateDate] [datetime] NULL ,
	CONSTRAINT [PK_StateDSNLookup] PRIMARY KEY  NONCLUSTERED 
	(
		[ID]
	)  ON [PRIMARY] 
) ON [PRIMARY]

GO
