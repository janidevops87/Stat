SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaProcessor](
	[CriteriaProcessorID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaID] [int] NOT NULL,
	[OrganizationID] [int] NOT NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_CriteriaProcessor] PRIMARY KEY NONCLUSTERED 
(
	[CriteriaProcessorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]') AND name = N'IX_CriteriaProcessor_CriteriaID')
CREATE NONCLUSTERED INDEX [IX_CriteriaProcessor_CriteriaID] ON [dbo].[CriteriaProcessor]
(
	[CriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor] CHECK CONSTRAINT [FK_dbo_CriteriaProcessor_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID] FOREIGN KEY([CriteriaID])
REFERENCES [dbo].[Criteria] ([CriteriaID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor] CHECK CONSTRAINT [FK_dbo_CriteriaProcessor_CriteriaID_dbo_Criteria_CriteriaID]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID] FOREIGN KEY([OrganizationID])
REFERENCES [dbo].[Organization] ([OrganizationID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaProcessor]'))
ALTER TABLE [dbo].[CriteriaProcessor] CHECK CONSTRAINT [FK_dbo_CriteriaProcessor_OrganizationID_dbo_Organization_OrganizationID]
GO
