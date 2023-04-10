/******************************************************************************
**		File: AddLogEventTypes.sql
**		Name: Add LogEventTypes
**		Desc: Add 2 new records to table LogEventType
**
**		Auth: Mike Berenson
**		Date: 11/29/2019
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      11/29/2019	Mike Berenson		initial
**		02/05/2020	Mike Berenson		Fixed identity_insert setting
*******************************************************************************/

SET IDENTITY_INSERT  dbo.LogEventType ON;
GO

IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 51)
BEGIN
	PRINT 'Inserting LogEventType record for "Email Sent"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (51, 'Email Sent', GETDATE(), NULL, 0, '');
END

IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 52)
BEGIN
	PRINT 'Inserting LogEventType record for "Page Sent"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (52, 'Page Sent', GETDATE(), NULL, 0, '');
END
GO

SET IDENTITY_INSERT  dbo.LogEventType OFF;
GO