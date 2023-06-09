SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NOK]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NOK](
	[NOKID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[NOKFirstName] [varchar](50) NULL,
	[NOKLastName] [varchar](50) NULL,
	[NOKPhone] [varchar](14) NULL,
	[NOKAddress] [varchar](255) NULL,
	[NOKCity] [varchar](50) NULL,
	[NOKStateID] [int] NULL,
	[NOKZip] [varchar](10) NULL,
	[NOKApproachRelation] [varchar](50) NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_NOK] PRIMARY KEY CLUSTERED 
(
	[NOKID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[NOK]'))
ALTER TABLE [dbo].[NOK]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[NOK]'))
ALTER TABLE [dbo].[NOK] CHECK CONSTRAINT [FK_dbo_NOK_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
