SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ScheduleItemPerson](
	[ScheduleItemPersonID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ScheduleItemID] [int] NOT NULL,
	[PersonID] [int] NOT NULL,
	[Priority] [smallint] NOT NULL,
	[LastModified] [datetime] NULL,
	[LastWebPersonID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_ScheduleItemPerson] PRIMARY KEY NONCLUSTERED 
(
	[ScheduleItemPersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
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
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]') AND name = N'PersonID')
CREATE NONCLUSTERED INDEX [PersonID] ON [dbo].[ScheduleItemPerson]
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ScheduleItemPerson]') AND name = N'ScheduleItemID')
CREATE NONCLUSTERED INDEX [ScheduleItemID] ON [dbo].[ScheduleItemPerson]
(
	[ScheduleItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
