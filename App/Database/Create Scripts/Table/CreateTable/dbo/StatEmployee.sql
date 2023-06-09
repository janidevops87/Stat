SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatEmployee]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatEmployee](
	[StatEmployeeID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[StatEmployeeFirstName] [varchar](50) NULL,
	[StatEmployeeLastName] [varchar](50) NULL,
	[StatEmployeeUserID] [varchar](50) NULL,
	[StatEmployeePassword] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[AllowCallDelete] [smallint] NULL,
	[AllowMaintainAccess] [smallint] NULL,
	[AllowSecurityAccess] [smallint] NULL,
	[AllowLicenseAccess] [smallint] NULL,
	[PersonID] [int] NULL,
	[StatEmployeeEmail] [varchar](30) NULL,
	[AllowStopTimerAccess] [smallint] NULL,
	[AllowIncompleteAccess] [smallint] NULL,
	[AllowScheduleAccess] [smallint] NULL,
	[UpdatedFlag] [smallint] NULL,
	[AllowRecoveryAccess] [smallint] NULL,
	[AllowInternetAccess] [smallint] NULL,
	[IntranetSecurityLevel] [smallint] NULL,
	[AllowEmployeeMaintTC] [smallint] NULL,
	[AllowEmployeeMaintFS] [smallint] NULL,
	[AllowEmployeeMaintAdmin] [smallint] NULL,
	[AllowEmployeeScheduleTC] [smallint] NULL,
	[AllowEmployeeScheduleFS] [smallint] NULL,
	[AllowQAReview] [smallint] NULL,
	[AllowRecycleCase] [smallint] NULL,
	[AllowCloseReferral] [smallint] NULL,
	[AllowASPSave] [int] NULL,
	[AllowViewDeletedLogEvents] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_StatEmployee] PRIMARY KEY CLUSTERED 
(
	[StatEmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[StatEmployee]') AND name = N'IDX_StatEmployee_PersonID')
CREATE NONCLUSTERED INDEX [IDX_StatEmployee_PersonID] ON [dbo].[StatEmployee]
(
	[PersonID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[StatEmployee]') AND name = N'IDX_StatEmployee_StatEmployeeLastName')
CREATE NONCLUSTERED INDEX [IDX_StatEmployee_StatEmployeeLastName] ON [dbo].[StatEmployee]
(
	[StatEmployeeLastName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[StatEmployee]') AND name = N'IDX_StatEmployee_StatEmployeeUserID')
CREATE NONCLUSTERED INDEX [IDX_StatEmployee_StatEmployeeUserID] ON [dbo].[StatEmployee]
(
	[StatEmployeeUserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 85) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowCallDe1__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowCallDe1__32]  DEFAULT (0) FOR [AllowCallDelete]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowMainta4__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowMainta4__32]  DEFAULT (0) FOR [AllowMaintainAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowSecuri5__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowSecuri5__32]  DEFAULT (0) FOR [AllowSecurityAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowLicens3__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowLicens3__32]  DEFAULT (0) FOR [AllowLicenseAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowStopTi6__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowStopTi6__32]  DEFAULT (0) FOR [AllowStopTimerAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowIncomp2__32]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowIncomp2__32]  DEFAULT (0) FOR [AllowIncompleteAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmploy_AllowSchedu1__35]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmploy_AllowSchedu1__35]  DEFAULT (0) FOR [AllowScheduleAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_UpdatedFlag]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_UpdatedFlag]  DEFAULT (0) FOR [UpdatedFlag]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowRecoveryAccess]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowRecoveryAccess]  DEFAULT (0) FOR [AllowRecoveryAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowInternetAccess]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowInternetAccess]  DEFAULT (0) FOR [AllowInternetAccess]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_IntranetSecurityLevel]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_IntranetSecurityLevel]  DEFAULT (0) FOR [IntranetSecurityLevel]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowEmployeeMaintTC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowEmployeeMaintTC]  DEFAULT (0) FOR [AllowEmployeeMaintTC]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowEmployeeMaintFS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowEmployeeMaintFS]  DEFAULT (0) FOR [AllowEmployeeMaintFS]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowEmployeeMaintAdmin]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowEmployeeMaintAdmin]  DEFAULT (0) FOR [AllowEmployeeMaintAdmin]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowEmployeeScheduleTC]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowEmployeeScheduleTC]  DEFAULT (0) FOR [AllowEmployeeScheduleTC]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowEmployeeScheduleFS]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowEmployeeScheduleFS]  DEFAULT (0) FOR [AllowEmployeeScheduleFS]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__StatEmplo__Allow__5E775CDF]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF__StatEmplo__Allow__5E775CDF]  DEFAULT (0) FOR [AllowRecycleCase]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowCloseReferral]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowCloseReferral]  DEFAULT (0) FOR [AllowCloseReferral]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_StatEmployee_AllowViewDeletedLogEvents]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[StatEmployee] ADD  CONSTRAINT [DF_StatEmployee_AllowViewDeletedLogEvents]  DEFAULT (0) FOR [AllowViewDeletedLogEvents]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[StatEmployee]'))
ALTER TABLE [dbo].[StatEmployee]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[StatEmployee]'))
ALTER TABLE [dbo].[StatEmployee] CHECK CONSTRAINT [FK_dbo_StatEmployee_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[StatEmployee]'))
ALTER TABLE [dbo].[StatEmployee]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID] FOREIGN KEY([PersonID])
REFERENCES [dbo].[Person] ([PersonID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID]') AND parent_object_id = OBJECT_ID(N'[dbo].[StatEmployee]'))
ALTER TABLE [dbo].[StatEmployee] CHECK CONSTRAINT [FK_dbo_StatEmployee_PersonID_dbo_Person_PersonID]
GO
