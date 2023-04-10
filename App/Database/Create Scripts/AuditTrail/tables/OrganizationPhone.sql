/******************************************************************************
**	File: OrganizationPhone.sql
**	Name: OrganizationPhone
**	Desc: Create table and add default columns for the table OrganizationPhone
**	Auth: jegerberich
**	Date: 9/24/2020
**	Revisions:	Date		Name			Description
**				09/24/2020	James Gerberich	Sync up with what's in production
**				09/24/2020	James Gerberich	Added new column SubLocationLevel
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[OrganizationPhone]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
/* Create OrganizationPhone If not exists */	

	CREATE TABLE [dbo].[OrganizationPhone]
	(
		[OrganizationPhoneID] [int] NOT NULL,
		[OrganizationID] [int] NULL,
		[PhoneID] [int] NULL,
		[LastModified] [datetime] NULL,
		[LastStatEmployeeId] [int] NULL,
		[AuditLogTypeId] [int] NULL,
		[SubLocationID] [int] NULL,
		[SubLocationLevelID] [int] NULL,
		[Inactive] [smallint] NULL,
		[SubLocationLevel] [varchar](5) NULL
	) ON [PRIMARY]
END
GO

--rename constraint, does not match between transactional and reporting
IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Inact__60C8EE4E]') AND type = 'D')
BEGIN
	EXEC sp_rename 'DF__Organizat__Inact__60C8EE4E', 'DF__Organizat__Inact__2E75A607', 'Object'
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__Organizat__Inact__2E75A607]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[OrganizationPhone] ADD CONSTRAINT [DF__Organizat__Inact__2E75A607] DEFAULT ((0)) FOR [Inactive]
END
GO

IF NOT EXISTS (
	SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[OrganizationPhone]')
	AND syscolumns.name = 'SubLocationLevel'
	)
BEGIN
	PRINT 'ALTERING TABLE OrganizationPhone Adding Column SubLocationLevel';
	ALTER TABLE [OrganizationPhone]
		ADD [SubLocationLevel] varchar(5) NULL;
END	
GO
