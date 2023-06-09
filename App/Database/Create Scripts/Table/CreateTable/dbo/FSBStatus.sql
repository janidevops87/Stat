SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[FSBStatus]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[FSBStatus](
	[FSBStatusId] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[FSBStatusName] [nvarchar](50) NOT NULL,
	[FSBCaseTypeId] [int] NOT NULL,
	[Color] [nvarchar](50) NOT NULL,
	[ThresholdMinutes] [smallint] NOT NULL,
	[InsertedBy] [nvarchar](50) NOT NULL,
	[UpdatedBy] [nvarchar](50) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[DateUpdated] [datetime] NOT NULL,
 CONSTRAINT [FSBStatus_PK] PRIMARY KEY NONCLUSTERED 
(
	[FSBStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY],
 CONSTRAINT [FSBStatus_UC1] UNIQUE NONCLUSTERED 
(
	[FSBStatusName] ASC,
	[FSBCaseTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBStatus__DateI__4087D29C]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBStatus] ADD  DEFAULT (getdate()) FOR [DateInserted]
END
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[DF__FSBStatus__DateU__417BF6D5]') AND type = 'D')
BEGIN
ALTER TABLE [dbo].[FSBStatus] ADD  DEFAULT (getdate()) FOR [DateUpdated]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBStatus]'))
ALTER TABLE [dbo].[FSBStatus]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId] FOREIGN KEY([FSBCaseTypeId])
REFERENCES [dbo].[FSBCaseType] ([FSBCaseTypeId])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]') AND parent_object_id = OBJECT_ID(N'[dbo].[FSBStatus]'))
ALTER TABLE [dbo].[FSBStatus] CHECK CONSTRAINT [FK_dbo_FSBStatus_FSBCaseTypeId_dbo_FSBCaseType_FSBCaseTypeId]
GO
