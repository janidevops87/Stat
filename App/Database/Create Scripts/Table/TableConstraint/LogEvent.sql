
		/******************************************************************************
		**	File: LogEvent(Constraint).sql 
		**	Name: LogEvent
		**	Desc: Creates constraints for LogEvent table
		**	Auth: Pam Scheichenost
		**	Date: 01/06/22020
		*******************************************************************************/
IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_LogEvent_LogEventDateTime')
BEGIN
	PRINT 'Creating Index IX_LogEvent_LogEventDateTime'
	CREATE NonClustered INDEX IX_LogEvent_LogEventDateTime ON dbo.LogEvent (LogEventDateTime) ON IDX
END
GO