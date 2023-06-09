if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Person]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Person]
GO

CREATE TABLE [dbo].[Person] (
	[PersonID] [int] IDENTITY (1, 1) NOT NULL ,
	[PersonFirst] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonMI] [varchar] (1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonLast] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonTypeID] [int] NULL ,
	[OrganizationID] [int] NULL ,
	[PersonNotes] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[PersonBusy] [smallint] NULL ,
	[Verified] [smallint] NULL ,
	[Inactive] [smallint] NULL ,
	[LastModified] [datetime] NULL ,
	[PersonBusyUntil] [smalldatetime] NULL ,
	[PersonTempNoteActive] [smallint] NULL ,
	[PersonTempNoteExpires] [smalldatetime] NULL ,
	[PersonTempNote] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[Unused] [varchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[UpdatedFlag] [smallint] NULL ,
	[AllowInternetScheduleAccess] [smallint] NULL ,
	[PersonSecurity] [int] NULL ,
	[PersonArchive] [smallint] NULL 
) ON [PRIMARY]
GO


