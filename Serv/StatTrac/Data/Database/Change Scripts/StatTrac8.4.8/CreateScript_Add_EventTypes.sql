 /* Add values new event types - StatTrac 8.4.8 release 
	Bret Knoll	03/12/09
 */
 

if(db_name() = '_ReferralProd' or db_name() = '_ReferralTest' or db_name() like '%dev%')
begin
	PRINT 'Adding Log Event data > LogEventType'


	SET IDENTITY_INSERT dbo.LogEventType ON


	IF (SELECT COUNT(*) FROM LogEventType WHERE LogEventTypeID IN (36, 37, 38, 39, 40, 41)) = 0 
	BEGIN
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(36, 'Donor Card', GetDate(), Null, 13444733, 'O')
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(37, 'DonorNet Acceptance', GetDate(), Null, 13444733, 'O')
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(38, 'DonorNet Decline', GetDate(), Null, 13444733, 'O')
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(39, 'Acknowledge to Evaluate', GetDate(), Null, 205, 'P')
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(40, 'Labs Pending', GetDate(), Null, 205, 'P')
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(41, 'Labs Received', GetDate(), Null, 13444733, 'O')

			PRINT '  -Insert row(s) added'
	END
	ELSE
	BEGIN
			PRINT '  -0 rows added - data already exists'
	END


	SET IDENTITY_INSERT dbo.LogEventType OFF

end
else
begin
	print 'only run add logevent on _ReferralProd'
end

if(db_name() = '_ReferralProd' or db_name() = '_ReferralTest' or db_name() like '%dev%')
begin
	PRINT 'Adding Log Event data > LogEventType'


	SET IDENTITY_INSERT dbo.LogEventType ON


	IF (SELECT COUNT(*) FROM LogEventType WHERE LogEventTypeID IN (42)) = 0 
	BEGIN
			INSERT LogEventType(LogEventTypeID, LogEventTypeName, LastModified, UpdatedFlag, EventColor, Code) VALUES(42, 'No Labs Received', GetDate(), Null, 13444733, 'O')

			PRINT '  -Insert row(s) added'
	END
	ELSE
	BEGIN
			PRINT '  -0 rows added - data already exists'
	END


	SET IDENTITY_INSERT dbo.LogEventType OFF

end
else
begin
	print 'only run add logevent on _ReferralProd'
end