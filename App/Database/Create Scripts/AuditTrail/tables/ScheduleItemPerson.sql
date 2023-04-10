/******************************************************************************
**	File: ScheduleItemPerson.sql
**	Name: ScheduleItemPerson
**	Desc: Create table
**	Auth: James Gerberich
**	Date: 03/23/2021
**	Revisions:	Date		Name				Description
**				03/23/2021	James Gerebrich		Adding table to AuditTrail
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[ScheduleItemPerson](
	[ScheduleItemPersonID] [int] NOT NULL,
	[ScheduleItemID] [int] NULL,
	[PersonID] [int] NULL,
	[Priority] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastWebPersonID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]')
	AND syscolumns.name = 'LastWebPersonID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItemPerson Adding Column LastWebPersonID';
	ALTER TABLE ScheduleItemPerson
		ADD LastWebPersonID int;
END	
GO
IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]')
	AND syscolumns.name = 'AuditLogTypeID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItemPerson Adding Column AuditLogTypeID';
	ALTER TABLE ScheduleItemPerson
		ADD AuditLogTypeID int;
END	
