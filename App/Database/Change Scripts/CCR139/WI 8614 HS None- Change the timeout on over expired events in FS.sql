 /******************************************************************************
		**	File: WI 8614 HS None- Change the timeout on over expired events in FS.sql
		**	Name: WI 8614 HS None- Change the timeout on over expired events in FS
		**	Desc: Change Timeout of over expired
		**	Auth: Bret Knoll
		**	Date: 12/9/2010
		**	
		*******************************************************************************/ 
		
IF EXISTS(
		SELECT parameterValueint 
		FROM stattracparameters 
		WHERE 
		ParameterName = 'FamilyServicesExpiredEvents'
		AND 
		parameterValueint = 30)
BEGIN
	PRINT 'WI 8614 Updating FamilyServicesExpiredEvents from 30 to 180 minutes'
	PRINT GETDATE()
	
	UPDATE stattracparameters
	SET parameterValueint = 180
	WHERE 
	ParameterName = 'FamilyServicesExpiredEvents'
	AND 
	parameterValueint = 30
	
	
END		