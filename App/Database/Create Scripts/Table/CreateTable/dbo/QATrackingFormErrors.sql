SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingFormErrors]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QATrackingFormErrors](
	[QATrackingFormErrorsID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QATrackingFormID] [int] NULL,
	[QAErrorLogID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
 CONSTRAINT [PK_QATrackingFormErrors] PRIMARY KEY NONCLUSTERED 
(
	[QATrackingFormErrorsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingFormErrors]') AND name = N'IDX_QATrackingFormErrors_QAErrorLogID')
CREATE NONCLUSTERED INDEX [IDX_QATrackingFormErrors_QAErrorLogID] ON [dbo].[QATrackingFormErrors]
(
	[QAErrorLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 95) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QATrackingFormErrors]') AND name = N'IDX_QATrackingFormErrors_QATrackingFormID')
CREATE NONCLUSTERED INDEX [IDX_QATrackingFormErrors_QATrackingFormID] ON [dbo].[QATrackingFormErrors]
(
	[QATrackingFormID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
