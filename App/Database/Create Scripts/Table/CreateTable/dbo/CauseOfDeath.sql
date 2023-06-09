SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CauseOfDeath]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CauseOfDeath](
	[CauseOfDeathID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CauseOfDeathName] [varchar](80) NULL,
	[CauseOfDeathOrganPotential] [smallint] NULL,
	[CauseOfDeathCoronerCase] [smallint] NULL,
	[Verified] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_CauseOfDeath_1__13] PRIMARY KEY CLUSTERED 
(
	[CauseOfDeathID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
