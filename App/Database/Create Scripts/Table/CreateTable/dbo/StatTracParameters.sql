SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StatTracParameters]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StatTracParameters](
	[StatTracParametersID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[ParameterName] [varchar](100) NULL,
	[ParameterValueString] [varchar](50) NULL,
	[parameterValueint] [char](10) NULL,
	[parameterValueDate] [datetime] NULL
) ON [PRIMARY]
END
GO
