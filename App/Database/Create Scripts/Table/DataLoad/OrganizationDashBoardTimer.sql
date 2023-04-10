 /***************************************************************************************************
**	Name: OrganizationDashBoardTimer
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	09/15/2001	Bret Knoll		Wrote the Insert Script
***************************************************************************************************/
-- select * from OrganizationDashBoardTimer
IF ((SELECT COUNT(*) FROM OrganizationDashBoardTimer) = 0)
BEGIN
	PRINT 'Loading OrganizationDashBoardTimer Data'
	
	
	
	INSERT OrganizationDashBoardTimer (OrganizationId, DashBoardWindowId, DashBoardTimerTypeId, ExpirationMinutes, LastModified, LastStatEmployeeId, AuditLogTypeId)
	SELECT Organization.OrganizationID, DashBoardTimerDefault.DashBoardWindowId, DashBoardTimerTypeId, ExpirationMinutes, GETDATE(),  45 , 1 FROM Organization, DashBoardTimerDefault
	WHERE OrganizationID IN (SELECT OrganizationID FROM 
	StatEmployee 
	JOIN Person On StatEmployee.PersonID = StatEmployee.PersonID)	
	AND 
	(
	ISNULL(OrganizationLOType, 0) > 0
	
	or Organization.OrganizationID = 194)


END

UPDATE OrganizationDashBoardTimer
SET ExpirationMinutes = 99999
WHERE DashBoardWindowId = 1
AND OrganizationID IN (14019,2309, 2257, 1100, 5115)

UPDATE OrganizationDashBoardTimer
SET ExpirationMinutes = 99999
WHERE DashBoardWindowId = 2
AND DashBoardTimerTypeId = 2
AND OrganizationID IN (14019,2309, 2257, 1100, 5115)
 