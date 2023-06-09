SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallCustomField]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallCustomField](
	[CallID] [int] NOT NULL,
	[CallCustomField1] [varchar](40) NULL,
	[CallCustomField2] [varchar](40) NULL,
	[CallCustomField3] [varchar](40) NULL,
	[CallCustomField4] [varchar](40) NULL,
	[CallCustomField5] [varchar](40) NULL,
	[CallCustomField6] [varchar](40) NULL,
	[CallCustomField7] [varchar](255) NULL,
	[CallCustomField8] [varchar](255) NULL,
	[CallCustomField9] [varchar](40) NULL,
	[CallCustomField10] [varchar](40) NULL,
	[CallCustomField11] [varchar](40) NULL,
	[CallCustomField12] [varchar](40) NULL,
	[CallCustomField13] [varchar](40) NULL,
	[CallCustomField14] [varchar](40) NULL,
	[CallCustomField15] [varchar](40) NULL,
	[CallCustomField16] [varchar](40) NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_CallCustomField] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallCustomField]'))
ALTER TABLE [dbo].[CallCustomField]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallCustomField]'))
ALTER TABLE [dbo].[CallCustomField] CHECK CONSTRAINT [FK_dbo_CallCustomField_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
