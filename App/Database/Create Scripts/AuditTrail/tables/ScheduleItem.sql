/******************************************************************************
**	File: ScheduleItem.sql
**	Name: ScheduleItem
**	Desc: Create table
**	Auth: James Gerberich
**	Date: 03/23/2021
**	Revisions:	Date		Name				Description
**				03/23/2021	James Gerebrich		Adding table to AuditTrail
******************************************************************************/

IF NOT EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[dbo].[ScheduleItem]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1)
BEGIN
CREATE TABLE [dbo].[ScheduleItem](
	[ScheduleItemID] [int] NOT NULL,
	[ScheduleGroupID] [int] NULL,
	[ScheduleItemName] [varchar](10) NULL,
	[ScheduleItemStartDate] [smalldatetime] NULL,
	[ScheduleItemStartTime] [varchar](5) NULL,
	[ScheduleItemEndDate] [smalldatetime] NULL,
	[ScheduleItemEndTime] [varchar](5) NULL,
	[LastModified] [datetime] NULL,
	[LastWebPersonID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
) ON [PRIMARY]
END

IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItem]')
	AND syscolumns.name = 'LastWebPersonID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItem Adding Column LastWebPersonID';
	ALTER TABLE ScheduleItem
		ADD LastWebPersonID int;
END	
GO
IF NOT EXISTS (SELECT 1 FROM syscolumns WHERE id = OBJECT_ID(N'[dbo].[ScheduleItem]')
	AND syscolumns.name = 'AuditLogTypeID'
	)
BEGIN
	PRINT 'ALTERING TABLE ScheduleItem Adding Column AuditLogTypeID';
	ALTER TABLE ScheduleItem
		ADD AuditLogTypeID int;
END	
