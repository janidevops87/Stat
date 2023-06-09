SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[InvoiceSourceCodePrices]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[InvoiceSourceCodePrices](
	[Client] [nvarchar](255) NULL,
	[SourceCode] [nvarchar](255) NULL,
	[Triage] [float] NULL,
	[Retainer] [float] NULL,
	[Message] [float] NULL,
	[ASP] [float] NULL,
	[SECONDARY] [float] NULL,
	[Approach] [float] NULL,
	[MEDSOC] [float] NULL,
	[donornet] [float] NULL,
	[global] [float] NULL,
	[import] [float] NULL,
	[dtasp] [float] NULL,
	[recordedconsent] [float] NULL,
	[CallSchedule] [float] NULL,
	[StatlineIT] [float] NULL
) ON [PRIMARY]
END
GO
