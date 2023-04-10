/******************************************************************************
**		File: AddProcessExceptionLogEventType.sql
**		Name: AddProcessException
**		Desc: Adds "Process Exception" Record to the LogEventType table, per CCRST228
**
**		Auth: Mike Berenson
**		Date: 12/22/2015
*******************************************************************************
**		Change History
*******************************************************************************
**		Date:		Author:				Description:
**		--------	--------			-------------------------------------------
**		12/22/2015	Mike Berenson		Initial
*******************************************************************************/

DECLARE @EventTypeName AS NVARCHAR(50), 
		@EventColor AS NVARCHAR(50), 
		@Code AS NVARCHAR(50), 
		@LogEventTypeId AS INT;

SELECT @EventTypeName = 'Process Exception'
	,@EventColor = '2263842'
	,@Code = 'U'
	,@LogEventTypeId = 50;

--Make sure record doesn't already exist with the wrong color - if so, delete it
IF EXISTS (SELECT * FROM LogEventType 
			WHERE LogEventTypeID = @LogEventTypeId 
			AND EventColor <> @EventColor)
BEGIN
	DELETE FROM LogEventType
	WHERE LogEventTypeID = @LogEventTypeId;
END

--Check to see if record already exists
IF NOT EXISTS (SELECT * FROM LogEventType 
				WHERE LogEventTypeID = @LogEventTypeId)
BEGIN
	--Insert record
	SET IDENTITY_INSERT LogEventType ON;
	INSERT LogEventType (LogEventTypeID, LogEventTypeName, LastModified, EventColor, Code)
	VALUES(@LogEventTypeId, @EventTypeName, GetDate(), @EventColor, @Code);
	SET IDENTITY_INSERT LogEventType OFF;
	PRINT 'Added LogEventType: ' + @EventTypeName;
END
	