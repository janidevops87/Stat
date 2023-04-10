if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[FuneralPlan]') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
drop table [dbo].[FuneralPlan]
GO

CREATE TABLE [dbo].[FuneralPlan] (
	[FuneralPlanId] [int] IDENTITY (1, 1) NOT NULL ,
	[FuneralPlanName] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL 
) ON [PRIMARY]
GO


