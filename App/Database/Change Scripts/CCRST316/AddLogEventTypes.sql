/******************************************************************************
**		File: AddLogEventTypes.sql
**		Name: Add LogEventTypes
**		Desc: Add 1 new record to table LogEventType
**
**		Auth: Pam Scheichenost
**		Date: 07/01/2020
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**      07/01/2020	Pam Scheichenost	initial
*******************************************************************************/
SET IDENTITY_INSERT  dbo.LogEventType ON;
GO
IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 54)
BEGIN
	PRINT 'Inserting LogEventType record for "Incoming E-Referral"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (54, 'Incoming E-Referral', GETDATE(), NULL, 0, '');
END
GO
IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 55)
BEGIN
	PRINT 'Inserting LogEventType record for "Pending E-Referral"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (55, 'Pending E-Referral', GETDATE(), NULL, 205, 'P');
END
GO
IF NOT EXISTS(SELECT 1 FROM LogEventType WHERE LogEventTypeID = 56)
BEGIN
	PRINT 'Inserting LogEventType record for "Incoming E-Referral"';
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code)
	VALUES (56, 'E-Referral Response', GETDATE(), NULL, 13444733, 'O');
END
GO
SET IDENTITY_INSERT  dbo.LogEventType OFF;
GO