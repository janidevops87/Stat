if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[AppropriateCounts]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[AppropriateCounts]
GO

CREATE TABLE [dbo].[AppropriateCounts] (
	[CallID] [int] NULL ,
	[appropriateType] [int] NULL ,
	[IndicationID] [int] NULL ,
	[DynamicCategory] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


