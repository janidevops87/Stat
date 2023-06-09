SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSBCase]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSBCase](
	[FSBCaseId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SourceCodeId] [int] NOT NULL,
	[ReferralNumber] [nvarchar](50) NOT NULL,
	[PatientName] [nvarchar](100) NOT NULL,
	[FSCPersonId] [int] NULL,
	[PreviousFSCPersonId] [int] NULL,
	[FSBCaseTypeId] [int] NOT NULL,
	[InsertedBy] [nvarchar](50) NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_FSBCase] PRIMARY KEY CLUSTERED 
(
	[FSBCaseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_FSBCase_LastModified]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBCase] ADD  CONSTRAINT [DF_FSBCase_LastModified]  DEFAULT (getdate()) FOR [LastModified]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCase]'))
ALTER TABLE [dbo].[FSBCase]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId] FOREIGN KEY([FSBCaseTypeId])
REFERENCES [dbo].[FSBCaseType] ([FSBCaseTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCase]'))
ALTER TABLE [dbo].[FSBCase] CHECK CONSTRAINT [FK_dbo_FSBCase_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCase]'))
ALTER TABLE [dbo].[FSBCase]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID] FOREIGN KEY([SourceCodeId])
REFERENCES [dbo].[SourceCode] ([SourceCodeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBCase]'))
ALTER TABLE [dbo].[FSBCase] CHECK CONSTRAINT [FK_dbo_FSBCase_SourceCodeId_dbo_SourceCode_SourceCodeID]
GO
