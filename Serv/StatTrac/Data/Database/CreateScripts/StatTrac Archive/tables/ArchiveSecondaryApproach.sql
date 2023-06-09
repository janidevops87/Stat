if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveSecondaryApproach]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveSecondaryApproach]
GO

CREATE TABLE [dbo].[ArchiveSecondaryApproach] (
	[CallId] [int] NOT NULL ,
	[SecondaryApproached] [smallint] NULL ,
	[SecondaryApproachedBy] [int] NULL ,
	[SecondaryApproachType] [smallint] NULL ,
	[SecondaryApproachOutcome] [smallint] NULL ,
	[SecondaryApproachReason] [smallint] NULL ,
	[SecondaryConsented] [smallint] NULL ,
	[SecondaryConsentBy] [int] NULL ,
	[SecondaryConsentOutcome] [smallint] NULL ,
	[SecondaryConsentResearch] [smallint] NULL ,
	[SecondaryRecoveryLocation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryHospitalApproach] [smallint] NULL ,
	[SecondaryHospitalApproachedBy] [int] NULL ,
	[SecondaryHospitalOutcome] [smallint] NULL ,
	[SecondaryConsentMedSocPaperwork] [smallint] NULL ,
	[SecondaryConsentMedSocObtainedBy] [int] NULL ,
	[SecondaryConsentFuneralPlans] [smallint] NULL ,
	[SecondaryConsentFuneralPlansOther] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryConsentLongSleeves] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 		
) ON [PRIMARY]
GO


