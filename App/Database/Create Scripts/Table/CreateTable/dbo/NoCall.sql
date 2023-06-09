SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[NoCall]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[NoCall](
	[NoCallID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[CallID] [int] NULL,
	[NoCallTypeID] [int] NULL,
	[NoCallDescription] [varchar](255) NULL,
	[LastModified] [datetime] NULL,
	[UpdatedFlag] [smallint] NULL,
 CONSTRAINT [PK_NoCall_1__13] PRIMARY KEY NONCLUSTERED 
(
	[NoCallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[NoCall]') AND name = N'IDX_NoCall_CallID')
CREATE CLUSTERED INDEX [IDX_NoCall_CallID] ON [dbo].[NoCall]
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[NoCall]'))
ALTER TABLE [dbo].[NoCall]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID] FOREIGN KEY([NoCallTypeID])
REFERENCES [dbo].[NoCallType] ([NoCallTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[NoCall]'))
ALTER TABLE [dbo].[NoCall] CHECK CONSTRAINT [FK_dbo_NoCall_NoCallTypeID_dbo_NoCallType_NoCallTypeID]
GO
