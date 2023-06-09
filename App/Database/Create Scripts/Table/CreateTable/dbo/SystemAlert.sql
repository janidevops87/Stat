SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SystemAlert]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[SystemAlert](
	[SystemAlertID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[SystemAlertDate] [smalldatetime] NULL,
	[StatEmployeeID] [int] NULL,
	[SystemAlertMessage] [varchar](255) NULL,
	[SystemAlertResolved] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_SystemAlert_2__13] PRIMARY KEY CLUSTERED 
(
	[SystemAlertID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF_SystemAler_SystemAlert1__20]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[SystemAlert] ADD  CONSTRAINT [DF_SystemAler_SystemAlert1__20]  DEFAULT (1) FOR [SystemAlertResolved]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SystemAlert]'))
ALTER TABLE [dbo].[SystemAlert]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID] FOREIGN KEY([StatEmployeeID])
REFERENCES [dbo].[StatEmployee] ([StatEmployeeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[SystemAlert]'))
ALTER TABLE [dbo].[SystemAlert] CHECK CONSTRAINT [FK_dbo_SystemAlert_StatEmployeeID_dbo_StatEmployee_StatEmployeeID]
GO
