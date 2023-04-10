/* ****************************************************************************************************
**	Name: LogEventType
**	Desc: Data Load for table LogEventType

****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/08/2011	ccarroll		Added events for Online Review
**  09/06/2011	ccarroll		Added events for Declared CTOD
**	06/13/2012	ccarroll		Add event for Case Hand Off
**	07/16/2014	ccarroll		Added events for Organ Med RO CCRST175
************************************************************************************************** */
SET NOCOUNT ON

DECLARE @EventTypeName AS NVARCHAR(50)
DECLARE @EventColor AS NVARCHAR(50)
DECLARE @Code AS NVARCHAR(50)

/* Add Online Review Pending */
SET @EventTypeName = 'Online Review Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Online Review Response */
SET @EventTypeName = 'Online Review Response'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Pending */
SET @EventTypeName = 'Declared CTOD Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Declared CTOD Confirmed */
SET @EventTypeName = 'Declared CTOD Confirmed'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END


/* Add Case Handoff LogEventTypeId:47 */
SET @EventTypeName = 'Case Hand Off'
SET @EventColor = '0'
SET @Code = ''
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Organ Med RO Pending LogEventTypeId:48 */
SET @EventTypeName = 'Organ Med RO Pending'
SET @EventColor = '205'
SET @Code = 'P'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END

/* Add Organ Med RO Confirmed LogEventTypeId:49 */
SET @EventTypeName = 'Organ Med RO Confirmed'
SET @EventColor = '13444733'
SET @Code = 'O'
IF NOT EXISTS (SELECT * FROM LogEventType WHERE LogEventTypeName = @EventTypeName)
	BEGIN
		INSERT LogEventType (LogEventTypeName, LastModified, EventColor, Code)
				VALUES(@EventTypeName, GetDate(), @EventColor, @Code)
	PRINT 'Adding LogEventType: ' + @EventTypeName
	END