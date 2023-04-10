/* 1.0 Add values new event types - StatTrac 8.4.6 release 
     ccarroll 06/17/2008 */
 

PRINT 'Adding Log Event data > LogEventType'
GO
SET IDENTITY_INSERT dbo.LogEventType ON
GO

IF (SELECT COUNT(*) FROM LogEventType WHERE LogEventTypeID IN (34, 35)) = 0 
BEGIN
		INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(34, 'Incoming Secondary', GetDate(), Null, 0, '')
		INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(35, 'IM Conversation', GetDate(), Null, 0, '')

		PRINT '  -Insert row(s) added'
END
ELSE
BEGIN
		PRINT '  -0 rows added - data already exists'
END
GO

SET IDENTITY_INSERT dbo.LogEventType OFF
GO