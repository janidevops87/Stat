/******************************************************************************
**		File: AddLogEventTypes.sql
**		Name: Add LogEventTypes
**		Desc: Add 1 new record to table LogEventType
**
**		Auth: Andrey Savin
**		Date: 2/5/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      2/5/2020	Andrey Savin		initial
*******************************************************************************/

SET IDENTITY_INSERT  dbo.LogEventType ON;
GO

IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 53)
BEGIN
	PRINT 'Inserting LogEventType record for "Verification Form Sent"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (53, 'Verification Form Sent', GETDATE(), NULL, 13444733, '');
END
GO

SET IDENTITY_INSERT  dbo.LogEventType OFF;
GO