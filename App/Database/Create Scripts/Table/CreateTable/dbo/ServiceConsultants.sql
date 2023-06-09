SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceConsultants]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceConsultants](
	[ID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Name] [varchar](100) NULL,
	[Email] [varchar](100) NULL,
	[PersonType] [varchar](100) NULL
) ON [PRIMARY]
END
GO
