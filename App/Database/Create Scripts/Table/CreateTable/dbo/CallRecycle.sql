SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[CallRecycle]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[CallRecycle](
	[CallID] [int] NOT NULL,
	[CallNumber] [varchar](15) NULL,
	[CallTypeID] [int] NULL,
	[CallDateTime] [smalldatetime] NULL,
	[StatEmployeeID] [smallint] NULL,
	[CallTotalTime] [varchar](15) NULL,
	[CallTempExclusive] [smallint] NULL,
	[Inactive] [smallint] NULL,
	[CallSeconds] [smallint] NULL,
	[LastModified] [datetime] NULL,
	[CallTemp] [smallint] NULL,
	[SourceCodeID] [int] NULL,
	[CallOpenByID] [int] NULL,
	[CallTempSavedByID] [int] NULL,
	[CallExtension] [numeric](5, 0) NULL,
	[UpdatedFlag] [smallint] NULL,
	[CallOpenByWebPersonId] [int] NULL,
	[RecycleDateTime] [datetime] NULL,
	[RecycleNCFlag] [smallint] NULL,
	[CallActive] [smallint] NULL,
 CONSTRAINT [PK_CallRecycle] PRIMARY KEY CLUSTERED 
(
	[CallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallRecycle]'))
ALTER TABLE [dbo].[CallRecycle]  WITH NOCHECK ADD  CONSTRAINT [FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID] FOREIGN KEY([CallTypeID])
REFERENCES [dbo].[CallType] ([CallTypeID])
NOT FOR REPLICATION 
GO
IF  EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID]') AND parent_object_id = OBJECT_ID(N'[dbo].[CallRecycle]'))
ALTER TABLE [dbo].[CallRecycle] CHECK CONSTRAINT [FK_dbo_CallRecycle_CallTypeID_dbo_CallType_CallTypeID]
GO
