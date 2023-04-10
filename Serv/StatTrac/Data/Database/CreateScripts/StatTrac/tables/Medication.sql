if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[Medication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[Medication]
GO

CREATE TABLE [dbo].[Medication] (
	[MedicationId] [int] IDENTITY (1, 1) NOT NULL ,
	[MedicationName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL ,
	[MedicationTypeUse] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


