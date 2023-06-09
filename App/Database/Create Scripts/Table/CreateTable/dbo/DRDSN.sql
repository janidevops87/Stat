SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DRDSN]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[DRDSN](
	[DRDSNID] [smallint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[DRDSNName] [varchar](25) NOT NULL,
	[DRDSNODBC] [varchar](25) NOT NULL,
	[DRDSNStateID] [tinyint] NULL,
	[LastModified] [smalldatetime] NULL,
	[CreateDate] [smalldatetime] NULL,
	[DRDSNServerName] [varchar](50) NULL,
	[DRDSNDBName] [varchar](50) NULL,
	[WebServiceEnable] [int] NULL,
	[WebServiceOrder] [int] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[DRDSNID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
