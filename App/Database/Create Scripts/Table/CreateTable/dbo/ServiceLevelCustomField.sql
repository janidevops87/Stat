SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ServiceLevelCustomField]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[ServiceLevelCustomField](
	[ServiceLevelID] [int] NOT NULL,
	[ServiceLevelCustomOn] [smallint] NULL,
	[ServiceLevelCustomTextAlert] [varchar](255) NULL,
	[ServiceLevelCustomListAlert] [varchar](255) NULL,
	[ServiceLevelCustomFieldLabel1] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel2] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel3] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel4] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel5] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel6] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel7] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel8] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel9] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel10] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel11] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel12] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel13] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel14] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel15] [varchar](40) NULL,
	[ServiceLevelCustomFieldLabel16] [varchar](40) NULL,
	[LastModified] [datetime] NULL,
 CONSTRAINT [PK_ServiceLevelCustomField] PRIMARY KEY CLUSTERED 
(
	[ServiceLevelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]
END
GO
