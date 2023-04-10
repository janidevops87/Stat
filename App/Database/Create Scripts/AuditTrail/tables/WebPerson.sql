/******************************************************************************
**	File: WebPerson.sql
**	Name: WebPerson
**	Desc: Create table
**	Auth: plscheichenost
**	Date: 01/05/2021
**	Revisions:	Date		Name				Description
**				01/05/2020	Pam Scheichenost	Sync up with what's in production, and then add changes for CCRST307
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[WebPerson]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
/* Create Referral If not exists */	

	CREATE TABLE [dbo].[WebPerson](
	[WebPersonID] [int] NOT NULL,
	[WebPersonUserName] [varchar](15) NULL,
	[PersonID] [int] NULL,
	[WebPersonPassword] [varchar](20) NULL,
	[UnusedField1] [int] NULL,
	[LastModified] [datetime] NULL,
	[WebPersonSessionCounter] [int] NULL,
	[UnusedField2] [int] NULL,
	[WebPersonLastSessionAccess] [smalldatetime] NULL,
	[WebPersonEmail] [varchar](100) NULL,
	[UpdatedFlag] [smallint] NULL,
	[WebPersonUserAgent] [varchar](100) NULL,
	[Access] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[SaltValue] [varchar](100) NULL,
	[HashedPassword] [varchar](50) NULL,
	[InternalSessionID] [uniqueidentifier] NULL,
	[PasswordExpiration] [datetime] NULL
) ON [PRIMARY]

END		

IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[WebPerson]') AND syscolumns.name = 'PasswordExpiration')
BEGIN
	PRINT 'ALTERING TABLE WebPerson Adding Column PasswordExpiration';
	ALTER TABLE [WebPerson] ADD [PasswordExpiration] [datetime] NULL;
END	
GO
