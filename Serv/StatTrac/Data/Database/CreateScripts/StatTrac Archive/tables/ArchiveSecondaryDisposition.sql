if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ArchiveSecondaryDisposition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ArchiveSecondaryDisposition]
GO

CREATE TABLE [dbo].[ArchiveSecondaryDisposition] (
	[SecondaryDispositionID] [int] NOT NULL ,
	[CallID] [int] NOT NULL ,
	[SubCriteriaID] [int] NOT NULL ,
	[SecondaryDispositionAppropriate] [smallint] NULL ,
	[SecondaryDispositionApproach] [smallint] NULL ,
	[SecondaryDispositionConsent] [smallint] NULL ,
	[SecondaryDispositionConversion] [smallint] NULL ,
	[SecondaryDispositionCRO] [smallint] NULL ,
	[LastStatEmployeeID] [int] NULL ,
	[AuditLogTypeID] [int] NULL ,
	[LastModified] [smalldatetime] NULL 
) ON [PRIMARY]
GO


