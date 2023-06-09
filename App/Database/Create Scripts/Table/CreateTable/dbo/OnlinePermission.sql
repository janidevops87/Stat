SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OnlinePermission]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OnlinePermission](
	[OnlinePermissionId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[OnlinePermissionName] [varchar](500) NULL,
	[OnlinePermissionString] [varchar](1000) NULL,
	[OnlinePermissionDescription] [varchar](1000) NULL,
 CONSTRAINT [PK_OnlinePermission] PRIMARY KEY CLUSTERED 
(
	[OnlinePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
