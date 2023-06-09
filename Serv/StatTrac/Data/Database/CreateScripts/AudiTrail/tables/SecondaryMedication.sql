if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryMedication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryMedication]
GO

CREATE TABLE [dbo].[SecondaryMedication] (
	[CallId] [int] NOT NULL ,
	[MedicationId] [int] NOT NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO

 CREATE    INDEX [PK_SecondaryMedication] ON [dbo].[SecondaryMedication]([CallId], [MedicationId]) WITH FILLFACTOR = 90 ON [IDX]
GO


