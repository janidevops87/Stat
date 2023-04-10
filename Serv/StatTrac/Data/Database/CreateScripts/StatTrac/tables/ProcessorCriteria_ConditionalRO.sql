if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[ProcessorCriteria_ConditionalRO]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[ProcessorCriteria_ConditionalRO]
GO

CREATE TABLE [dbo].[ProcessorCriteria_ConditionalRO] (
	[ProcessorCriteria_ConditionalROID] [int] IDENTITY (1, 1) NOT NULL ,
	[FSIndicationID] [int] NULL ,
	[FSConditionID] [int] NULL ,
	[FSAppropriateID] [int] NULL ,
	[SubCriteriaID] [int] NULL 
) ON [PRIMARY]
GO


