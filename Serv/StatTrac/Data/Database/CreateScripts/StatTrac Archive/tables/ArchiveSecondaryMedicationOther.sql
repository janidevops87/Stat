if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveSecondaryMedicationOther]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveSecondaryMedicationOther]
GO

CREATE TABLE [dbo].[ArchiveSecondaryMedicationOther] (
	[SecondaryMedicationOtherId] [int] NOT NULL ,
	[CallId] [int] NOT NULL ,
	[MedicationId] [int] NOT NULL ,
	[SecondaryMedicationOtherTypeUse] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[SecondaryMedicationOtherName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMedicationOtherDose] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[SecondaryMedicationOtherStartDate] [smalldatetime] NULL ,
	[SecondaryMedicationOtherEndDate] [smalldatetime] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


