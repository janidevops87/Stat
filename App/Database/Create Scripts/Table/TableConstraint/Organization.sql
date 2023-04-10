  /***************************************************************************************************
**	Name: Organization
**	Desc: Add Primary keys, Unique keys, and Default Keys to Organization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/



IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Organization')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_Organization'
	ALTER TABLE dbo.Organization ADD CONSTRAINT PK_Organization PRIMARY KEY Clustered (OrganizationId) 
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Organization_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_Organization_LastModified'
	ALTER TABLE dbo.Organization ADD CONSTRAINT DF_Organization_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO

/****** Object:  Index [CountyID]    Script Date: 06/25/2009 11:52:51 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_CountyID')
BEGIN
	PRINT 'CREATE NONCLUSTERED INDEX [IDX_Organization_CountyID] '
	CREATE NONCLUSTERED INDEX [IDX_Organization_CountyID] ON [dbo].[Organization] 
	(
		[CountyID] ASC
	)
	INCLUDE ( [OrganizationID],
	[OrganizationName]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 95) ON [IDX]
	
END
GO


/****** Object:  Index [OrganizationName]    Script Date: 06/25/2009 11:52:51 ******/
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'OrganizationName')
CREATE NONCLUSTERED INDEX [OrganizationName] ON [dbo].[Organization] 
(
	[OrganizationName] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
GO
/****** Object:  Statistic [hind_126_33]    Script Date: 06/25/2009 11:52:51 ******/
if not exists (select * from sys.stats where name = N'hind_126_33' and object_id = object_id(N'[dbo].[Organization]'))
CREATE STATISTICS [hind_126_33] ON [dbo].[Organization]([OrganizationLOEnabled])
GO
/****** Object:  Statistic [hind_152_1]    Script Date: 06/25/2009 11:52:51 ******/
if not exists (select * from sys.stats where name = N'hind_152_1' and object_id = object_id(N'[dbo].[Organization]'))
CREATE STATISTICS [hind_152_1] ON [dbo].[Organization]([OrganizationID])
GO
/****** Object:  Statistic [hind_152_33]    Script Date: 06/25/2009 11:52:51 ******/
if not exists (select * from sys.stats where name = N'hind_152_33' and object_id = object_id(N'[dbo].[Organization]'))
CREATE STATISTICS [hind_152_33] ON [dbo].[Organization]([OrganizationLOEnabled])
GO
/****** Object:  Statistic [OrganizationCity]    Script Date: 06/25/2009 11:52:51 ******/
if not exists (select * from sys.stats where name = N'OrganizationCity' and object_id = object_id(N'[dbo].[Organization]'))
CREATE STATISTICS [OrganizationCity] ON [dbo].[Organization]([OrganizationCity])
GO
/****** Object:  Statistic [OrganizationZipCode]    Script Date: 06/25/2009 11:52:51 ******/
if not exists (select * from sys.stats where name = N'OrganizationZipCode' and object_id = object_id(N'[dbo].[Organization]'))
CREATE STATISTICS [OrganizationZipCode] ON [dbo].[Organization]([OrganizationZipCode])
GO
/****** Object:  Trigger [dbo].[tg_OrganizationDelete]    Script Date: 06/25/2009 11:52:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[tg_OrganizationDelete]'))
EXEC dbo.sp_executesql @statement = N'

/****** Object:  Trigger dbo.tg_OrganizationDelete    Script Date: 2/24/99 1:12:49 AM ******/
/****** Object:  Trigger dbo.tg_OrganizationDelete    Script Date: 9/11/97 9:10:31 PM ******/
CREATE TRIGGER tg_OrganizationDelete ON dbo.Organization
FOR DELETE
AS
	DELETE	AlertOrganization
	FROM	AlertOrganization, deleted
	WHERE	AlertOrganization.OrganizationID = deleted.OrganizationID
	DELETE	CriteriaOrganization
	FROM	CriteriaOrganization, deleted
	WHERE	CriteriaOrganization.OrganizationID = deleted.OrganizationID
	DELETE	ScheduleGroupOrganization
	FROM	ScheduleGroupOrganization, deleted
	WHERE	ScheduleGroupOrganization.OrganizationID = deleted.OrganizationID
	DELETE	ServiceLevel30Organization
	FROM	ServiceLevel30Organization, deleted
	WHERE	ServiceLevel30Organization.OrganizationID = deleted.OrganizationID
	DELETE	WebReportGroupOrg
	FROM	WebReportGroupOrg, deleted
	WHERE	WebReportGroupOrg.OrganizationID = deleted.OrganizationID
	DELETE	Person
	FROM	Person, deleted
	WHERE	Person.OrganizationID = deleted.OrganizationID
	DELETE	SourceCodeOrganization
	FROM	SourceCodeOrganization, deleted
	WHERE	SourceCodeOrganization.OrganizationID = deleted.OrganizationID

' 
GO
DENY DELETE ON [dbo].[Organization] TO [statline_users] AS [dbo]
GO
DENY INSERT ON [dbo].[Organization] TO [statline_users] AS [dbo]
GO
DENY REFERENCES ON [dbo].[Organization] TO [statline_users] AS [dbo]
GO
DENY SELECT ON [dbo].[Organization] TO [statline_users] AS [dbo]
GO
DENY UPDATE ON [dbo].[Organization] TO [statline_users] AS [dbo]
GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Organizati_Organizatio1__14]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organizati_Organizatio1__14]  DEFAULT (0) FOR [OrganizationConfCallCust]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF_Organization_Unused2]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF_Organization_Unused2]  DEFAULT (0) FOR [Unused2]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Organizat__Organ__68543626]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__Organ__68543626]  DEFAULT (0) FOR [OrganizationLO]
END

GO
IF NOT EXISTS (SELECT * FROM dbo.sysobjects WHERE id = OBJECT_ID(N'[DF__Organizat__Organ__69485A5F]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[Organization] ADD  CONSTRAINT [DF__Organizat__Organ__69485A5F]  DEFAULT (0) FOR [OrganizationLOEnabled]
END
GO
/****** Object:  Index [Organization54]    Script Date: 06/24/2011 07:22:39 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'Organization54')
BEGIN
	PRINT 'DROP INDEX [Organization54] '
	DROP INDEX [Organization54] ON [dbo].[Organization] WITH ( ONLINE = OFF )
END
GO
PRINT 'CREATE NONCLUSTERED INDEX '
IF  NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IX_Organization_OrganizationID_OrganizationLOEnabled_OrganizationName')
BEGIN


	/****** Object:  Index [Organization54]    Script Date: 06/24/2011 07:22:39 ******/
	CREATE NONCLUSTERED INDEX [IX_Organization_OrganizationID_OrganizationLOEnabled_OrganizationName] ON [dbo].[Organization] 
	(
		[OrganizationID] ASC,
		[OrganizationLOEnabled] ASC,
		[OrganizationName] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
END
GO


/****** Object:  Index [OrganizationName]    Script Date: 06/24/2011 07:22:48 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'OrganizationName')
BEGIN
	PRINT 'DROP INDEX [OrganizationName] '
	DROP INDEX [OrganizationName] ON [dbo].[Organization] WITH ( ONLINE = OFF )
END
GO
/****** Object:  Index [Organization52]    Script Date: 06/24/2011 07:27:09 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'Organization52')
BEGIN
	PRINT 'DROP INDEX [Organization52]'
	DROP INDEX [Organization52] ON [dbo].[Organization] WITH ( ONLINE = OFF )
END
GO
/****** Object:  Index [Organization53]    Script Date: 06/24/2011 07:27:18 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'Organization53')
BEGIN
	PRINT 'DROP INDEX [Organization53] '
	DROP INDEX [Organization53] ON [dbo].[Organization] WITH ( ONLINE = OFF )
END

GO

/****** Object:  Index [IDX_Organization_StateID]    Script Date: 06/24/2011 07:35:06 ******/
IF  EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_StateID')
BEGIN
	PRINT 'DROP INDEX [IDX_Organization_StateID] '
	DROP INDEX [IDX_Organization_StateID] ON [dbo].[Organization] WITH ( ONLINE = OFF )
END
GO

PRINT 'CREATE NONCLUSTERED INDEX [IDX_Organization_StateID]'
IF  NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[Organization]') AND name = N'IDX_Organization_StateID')
BEGIN

	/****** Object:  Index [IDX_Organization_StateID]    Script Date: 06/24/2011 07:35:06 ******/
	CREATE NONCLUSTERED INDEX [IDX_Organization_StateID] ON [dbo].[Organization] 
	(
		[StateID] ASC
	)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON, FILLFACTOR = 90) ON [IDX]
END
GO

