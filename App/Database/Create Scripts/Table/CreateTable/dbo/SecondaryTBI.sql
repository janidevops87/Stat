SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryTBI]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecondaryTBI](
	[CallID] [int] NOT NULL,
	[SecondaryTBINumber] [varchar](25) NULL,
	[SecondaryTBIIssuedStatEmployeeID] [int] NULL,
	[SecondaryTBIPrefixDate] [varchar](10) NULL,
	[SecondaryTBIAssignmentNotNeeded] [smallint] NULL,
	[SecondaryTBIAssignmentNotNeededStatEmployeeID] [int] NULL,
	[LastStatEmployeeID] [int] NULL,
	[SecondaryTBIComment] [varchar](250) NULL,
	[CreateDate] [smalldatetime] NULL,
	[LastModified] [smalldatetime] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_SecondaryTBI] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryTBI]'))
ALTER TABLE [dbo].[SecondaryTBI]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryTBI]'))
ALTER TABLE [dbo].[SecondaryTBI] CHECK CONSTRAINT [FK_dbo_SecondaryTBI_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
