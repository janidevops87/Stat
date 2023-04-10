if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveSecondaryMedication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveSecondaryMedication]
GO

CREATE TABLE [dbo].[ArchiveSecondaryMedication] (
	[CallId] [int] NOT NULL ,
	[MedicationId] [int] NOT NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


