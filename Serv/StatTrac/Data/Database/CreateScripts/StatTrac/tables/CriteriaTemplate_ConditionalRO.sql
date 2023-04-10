if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[CriteriaTemplate_ConditionalRO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[CriteriaTemplate_ConditionalRO]
GO

CREATE TABLE [dbo].[CriteriaTemplate_ConditionalRO] (
	[CriteriaTemplate_ConditionalROID] [int] IDENTITY (1, 1) NOT NULL ,
	[CriteriaTemplateId] [int] NULL ,
	[FSIndicationId] [int] NULL ,
	[FSConditionId] [int] NULL ,
	[FSAppropriateId] [int] NULL 
) ON [PRIMARY]
GO


