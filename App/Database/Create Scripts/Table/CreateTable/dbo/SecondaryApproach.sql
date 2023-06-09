SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SecondaryApproach]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SecondaryApproach](
	[CallId] [int] NOT NULL,
	[SecondaryApproached] [smallint] NULL,
	[SecondaryApproachedBy] [int] NULL,
	[SecondaryApproachType] [smallint] NULL,
	[SecondaryApproachOutcome] [smallint] NULL,
	[SecondaryApproachReason] [smallint] NULL,
	[SecondaryConsented] [smallint] NULL,
	[SecondaryConsentBy] [int] NULL,
	[SecondaryConsentOutcome] [smallint] NULL,
	[SecondaryConsentResearch] [smallint] NULL,
	[SecondaryRecoveryLocation] [varchar](50) NULL,
	[SecondaryHospitalApproach] [smallint] NULL,
	[SecondaryHospitalApproachedBy] [int] NULL,
	[SecondaryHospitalOutcome] [smallint] NULL,
	[SecondaryConsentMedSocPaperwork] [smallint] NULL,
	[SecondaryConsentMedSocObtainedBy] [int] NULL,
	[SecondaryConsentFuneralPlans] [smallint] NULL,
	[SecondaryConsentFuneralPlansOther] [varchar](50) NULL,
	[SecondaryConsentLongSleeves] [smallint] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[LastModified] [smalldatetime] NULL,
 CONSTRAINT [PK_SecondaryApproach] PRIMARY KEY CLUSTERED 
(
	[CallId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryApproach]'))
ALTER TABLE [dbo].[SecondaryApproach]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId] FOREIGN KEY([AuditLogTypeID])
REFERENCES [dbo].[AuditLogType] ([AuditLogTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[SecondaryApproach]'))
ALTER TABLE [dbo].[SecondaryApproach] CHECK CONSTRAINT [FK_dbo_SecondaryApproach_AuditLogTypeID_dbo_AuditLogType_AuditLogTypeId]
GO
