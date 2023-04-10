if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryMedication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryMedication]
GO

CREATE TABLE [dbo].[SecondaryMedication] (
	[CallId] [int] NOT NULL ,
	[MedicationId] [int] NOT NULL 
) ON [PRIMARY]
GO


