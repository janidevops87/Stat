if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[backup_Medication_022806]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[backup_Medication_022806]
GO

CREATE TABLE [dbo].[backup_Medication_022806] (
	[MedicationId] [int] IDENTITY (1, 1) NOT NULL ,
	[MedicationName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MedicationTypeUse] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


