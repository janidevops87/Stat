SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CriteriaWeightUnit]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CriteriaWeightUnit](
	[CriteriaWeightUnitID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CriteriaWeightUnitName] [nvarchar](20) NULL,
	[DisplayOrder] [int] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_CriteriaWeightUnit] PRIMARY KEY CLUSTERED 
(
	[CriteriaWeightUnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_CriteriaWeightUnit_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[CriteriaWeightUnit] ADD  CONSTRAINT [DF_CriteriaWeightUnit_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaWeightUnit]'))
ALTER TABLE [dbo].[CriteriaWeightUnit]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CriteriaWeightUnit]'))
ALTER TABLE [dbo].[CriteriaWeightUnit] CHECK CONSTRAINT [FK_dbo_CriteriaWeightUnit_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
