if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FSBCase]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FSBCase]
GO

CREATE TABLE [dbo].[FSBCase] (
	[FSBCaseId] [int] IDENTITY (1, 1) NOT NULL ,
	[SourceCodeId] [int] NOT NULL ,
	[ReferralNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[PatientName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FSCPersonId] [int] NULL ,
	[PreviousFSCPersonId] [int] NULL ,
	[FSBCaseTypeId] [int] NOT NULL ,
	[InsertedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[UpdatedBy] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[DateInserted] [datetime] NOT NULL ,
	[DateUpdated] [datetime] NOT NULL 
) ON [PRIMARY]
GO


