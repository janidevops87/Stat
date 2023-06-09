SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorLog]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[QAErrorLog](
	[QAErrorLogID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[QATrackingID] [int] NULL,
	[QAProcessStepID] [int] NULL,
	[QAErrorLocationID] [int] NULL,
	[QAErrorTypeID] [int] NULL,
	[QAMonitoringFormTemplateID] [int] NULL,
	[StatEmployeeID] [int] NULL,
	[QAErrorLogNumberOfErrors] [int] NULL,
	[QAErrorLogDateTime] [datetime] NULL,
	[QAErrorLogHowIdentifiedID] [int] NULL,
	[QAErrorLogTicketNumber] [varchar](20) NULL,
	[QAErrorLogComments] [varchar](1000) NULL,
	[QAErrorLogCorrection] [varchar](1000) NULL,
	[QAErrorLogCorrectionPersonID] [int] NULL,
	[QAErrorLogCorrectionLastModified] [datetime] NULL,
	[QAErrorLogPointsYes] [smallint] NULL,
	[QAErrorLogPointsNo] [smallint] NULL,
	[QAErrorLogPointsNA] [smallint] NULL,
	[QAErrorStatusID] [int] NULL,
	[LastModified] [datetime] NULL,
	[LastStatEmployeeID] [int] NULL,
	[AuditLogTypeID] [int] NULL,
	[QAErrorLogPersonID] [int] NULL,
 CONSTRAINT [PK_QAErrorLog] PRIMARY KEY NONCLUSTERED 
(
	[QAErrorLogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorLog]') AND name = N'IDX_QAErrorLog_QAErrorStatusIDQAErrorLogPersonID_includes')
CREATE NONCLUSTERED INDEX [IDX_QAErrorLog_QAErrorStatusIDQAErrorLogPersonID_includes] ON [dbo].[QAErrorLog]
(
	[QAErrorStatusID] ASC,
	[QAErrorLogPersonID] ASC
)
INCLUDE([QAErrorLogID],[QATrackingID],[QAProcessStepID],[QAErrorLocationID],[QAErrorTypeID],[QAMonitoringFormTemplateID],[StatEmployeeID],[QAErrorLogHowIdentifiedID],[LastModified],[LastStatEmployeeID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[QAErrorLog]') AND name = N'IDX_QAErrorLog_QATrackingID_QAErrorLogDateTime')
CREATE NONCLUSTERED INDEX [IDX_QAErrorLog_QATrackingID_QAErrorLogDateTime] ON [dbo].[QAErrorLog]
(
	[QATrackingID] ASC,
	[QAErrorLogDateTime] ASC
)
INCLUDE([QAErrorLogID],[QAErrorTypeID],[QAMonitoringFormTemplateID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [IDX]
GO
