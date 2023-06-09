SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FuneralPlan]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FuneralPlan](
	[FuneralPlanId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FuneralPlanName] [varchar](20) NULL,
 CONSTRAINT [PK_SecondaryFuneralPlans] PRIMARY KEY NONCLUSTERED 
(
	[FuneralPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
