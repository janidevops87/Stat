  /***************************************************************************************************
**	Name: DashBoardTimerDefault
**	Desc: Add Initial Data
**************************************R**************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/ 
IF ((SELECT COUNT(*) FROM DashBoardTimerDefault) = 0)
BEGIN
	DECLARE @DashboardWindowID INT

	SELECT @DashboardWindowID = DashboardWindow.DashboardWindowID FROM DashboardWindow WHERE DashboardWindow.DashBoardWindow = 'Incompletes'
	SELECT @DashboardWindowID

	INSERT DashBoardTimerDefault (DashBoardTimerTypeId, DashBoardWindowId, ExpirationMinutes, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DashBoardTimerType.DashBoardTimerTypeId, 
		@DashboardWindowID, 
		CASE 
		WHEN DashBoardTimerType.DashBoardTimerType = 'Expired' THEN  15
		WHEN DashBoardTimerType.DashBoardTimerType = 'Over Expiration (amount of time after expiration)' THEN  7
		END,
		GETDATE(),
		45,
		1	
		FROM DashBoardTimerType
		WHERE DashBoardTimerType IN ('Expired', 'Over Expiration (amount of time after expiration)')

	SELECT @DashboardWindowID = DashboardWindow.DashboardWindowID FROM DashboardWindow WHERE DashboardWindow.DashBoardWindow = 'Pending'
	SELECT @DashboardWindowID

	INSERT DashBoardTimerDefault (DashBoardTimerTypeId, DashBoardWindowId, ExpirationMinutes, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DashBoardTimerType.DashBoardTimerTypeId, 
		@DashboardWindowID, 
		CASE 
		WHEN DashBoardTimerType.DashBoardTimerType = 'Expired' THEN  10
		WHEN DashBoardTimerType.DashBoardTimerType = 'Over Expiration (amount of time after expiration)' THEN  2
		WHEN DashBoardTimerType.DashBoardTimerType = 'Unlock Events' THEN  15
		WHEN DashBoardTimerType.DashBoardTimerType = 'Acknowledge to Evaluate Expiration' THEN 20
		END,
		GETDATE(),
		45,
		1	
		FROM DashBoardTimerType
		WHERE DashBoardTimerType IN ('Expired', 'Over Expiration (amount of time after expiration)', 'Unlock Events', 'Acknowledge to Evaluate Expiration')

	SELECT @DashboardWindowID = DashboardWindow.DashboardWindowID FROM DashboardWindow WHERE DashboardWindow.DashBoardWindow = 'OASIS Active Cases'
	SELECT @DashboardWindowID

	INSERT DashBoardTimerDefault (DashBoardTimerTypeId, DashBoardWindowId, ExpirationMinutes, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DashBoardTimerType.DashBoardTimerTypeId, 
		@DashboardWindowID, 
		CASE 
		WHEN DashBoardTimerType.DashBoardTimerType = 'Expired' THEN  30
		WHEN DashBoardTimerType.DashBoardTimerType = 'Pending Expiration' THEN 20
		END,
		GETDATE(),
		45,
		1	
		FROM DashBoardTimerType
		WHERE DashBoardTimerType IN ('Expired', 'Pending Expiration')

	SELECT @DashboardWindowID = DashboardWindow.DashboardWindowID FROM DashboardWindow WHERE DashboardWindow.DashBoardWindow = 'FS Active Cases'
	SELECT @DashboardWindowID

	INSERT DashBoardTimerDefault (DashBoardTimerTypeId, DashBoardWindowId, ExpirationMinutes, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT 
		DashBoardTimerType.DashBoardTimerTypeId, 
		@DashboardWindowID, 
		CASE 
		WHEN DashBoardTimerType.DashBoardTimerType = 'Secondary Pending' THEN  20		
		END,
		GETDATE(),
		45,
		1	
		FROM DashBoardTimerType
		WHERE DashBoardTimerType IN ('Secondary Pending')
		
END
