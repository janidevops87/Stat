if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryMedicationOther]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryMedicationOther]
GO

CREATE TABLE [dbo].[SecondaryMedicationOther] (
	[SecondaryMedicationOtherId] [int] IDENTITY (1, 1) NOT NULL ,
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

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryMedicationOtherStartDate] ON [dbo].[SecondaryMedicationOther] ([SecondaryMedicationOtherStartDate]) ')
GO

/****** The index created by the following statement is for internal use only. ******/
/****** It is not a real index but exists as statistics only. ******/
if (@@microsoftversion > 0x07000000 )
EXEC ('CREATE STATISTICS [SecondaryMedicationOtherEndDate] ON [dbo].[SecondaryMedicationOther] ([SecondaryMedicationOtherEndDate]) ')
GO

 CREATE    INDEX [PK_SecondaryMedicationOther] ON [dbo].[SecondaryMedicationOther]([SecondaryMedicationOtherId]) WITH FILLFACTOR = 90 ON [IDX]
GO


