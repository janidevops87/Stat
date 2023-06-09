SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ProcessorCriteria_ConditionalRO]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ProcessorCriteria_ConditionalRO](
	[ProcessorCriteria_ConditionalROID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FSIndicationID] [int] NULL,
	[FSConditionID] [int] NULL,
	[FSAppropriateID] [int] NULL,
	[SubCriteriaID] [int] NULL,
 CONSTRAINT [PK_ProcessorCriteria_ConditionalRO] PRIMARY KEY NONCLUSTERED 
(
	[ProcessorCriteria_ConditionalROID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[ProcessorCriteria_ConditionalRO]') AND name = N'FK_SubCriteriaID')
CREATE NONCLUSTERED INDEX [FK_SubCriteriaID] ON [dbo].[ProcessorCriteria_ConditionalRO]
(
	[SubCriteriaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
