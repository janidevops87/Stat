IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'U' AND name = 'CloseCaseTrigger')
	BEGIN
		CREATE TABLE CloseCaseTrigger
		(
		   CloseCaseTriggerID INT IDENTITY(1,1),
		   CloseCaseTriggerName NVARCHAR(100)
		)
	
		GRANT SELECT ON CloseCaseTrigger TO PUBLIC
		PRINT 'CREATE TABLE CloseCaseTrigger'
		
	END




