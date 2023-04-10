 CREATE NONCLUSTERED INDEX [<Name of Missing Index, sysname,>] ON [dbo].[QAErrorLog] 
(
	[QAErrorLocationID] ASC,
	[StatEmployeeID] ASC
)
INCLUDE ( [QAErrorLogID],
[QAProcessStepID],
[QAErrorTypeID],
[QAErrorLogNumberOfErrors],
[QAErrorLogDateTime],
[QAErrorLogHowIdentifiedID],
[QAErrorLogTicketNumber],
[QAErrorLogComments],
[QAErrorLogCorrection],
[QAErrorLogCorrectionPersonID],
[QAErrorLogCorrectionLastModified],
[QAErrorStatusID]) WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO