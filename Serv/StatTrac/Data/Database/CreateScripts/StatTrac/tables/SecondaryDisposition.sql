if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SecondaryDisposition]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[SecondaryDisposition]
GO

CREATE TABLE [dbo].[SecondaryDisposition] (
	[SecondaryDispositionID] [int] IDENTITY (1, 1) NOT NULL ,
	[CallID] [int] NOT NULL ,
	[SubCriteriaID] [int] NOT NULL ,
	[SecondaryDispositionAppropriate] [smallint] NULL ,
	[SecondaryDispositionApproach] [smallint] NULL ,
	[SecondaryDispositionConsent] [smallint] NULL ,
	[SecondaryDispositionConversion] [smallint] NULL ,
	[SecondaryDispositionCRO] [smallint] NULL 
) ON [PRIMARY]
GO


