if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaIndication]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaIndication]
GO

CREATE TABLE [dbo].[CriteriaIndication] (
	[CriteriaIndicationID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaID] [int] NULL ,
	[IndicationID] [int] NULL ,
	[LastModified] [smalldatetime] NULL ,
	[IndicationHighRisk] [smallint] NULL ,
	[IndicationStandardMRO] [smallint] NULL ,
	[UpdatedFlag] [smallint] NULL 
) ON [PRIMARY]
GO


