

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDashBoardTimerSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDashBoardTimerSelect'
		DROP Procedure OrganizationDashBoardTimerSelect
	END
GO

PRINT 'Creating Procedure OrganizationDashBoardTimerSelect'
GO
CREATE Procedure OrganizationDashBoardTimerSelect
(
		@OrganizationDashBoardTimerId int = null,
		@OrganizationId int = null,
		@DashBoardTimerTypeId int = null					
)
AS
/******************************************************************************
**	File: OrganizationDashBoardTimerSelect.sql
**	Name: OrganizationDashBoardTimerSelect
**	Desc: Selects multiple rows of OrganizationDashBoardTimer Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/14/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/14/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

	SELECT
		OrganizationDashBoardTimer.OrganizationDashBoardTimerId,
		OrganizationDashBoardTimer.OrganizationId,
		DashBoardWindow.DashBoardWindowId,
		DashBoardWindow.DashBoardWindow,
		OrganizationDashBoardTimer.DashBoardTimerTypeId,
		DashBoardTimerType AS DashBoardTimerType,		
		OrganizationDashBoardTimer.ExpirationMinutes,
		OrganizationDashBoardTimer.LastModified,
		OrganizationDashBoardTimer.LastStatEmployeeId,
		OrganizationDashBoardTimer.AuditLogTypeId
	FROM 
		dbo.OrganizationDashBoardTimer 
	JOIN
		DashBoardTimerType ON DashBoardTimerType.DashBoardTimerTypeId = OrganizationDashBoardTimer.DashBoardTimerTypeId	
	JOIN 
		DashBoardWindow ON DashBoardWindow.DashBoardWindowId = OrganizationDashBoardTimer.DashBoardWindowId
	WHERE 
		OrganizationDashBoardTimer.OrganizationDashBoardTimerId = ISNULL(@OrganizationDashBoardTimerId, OrganizationDashBoardTimer.OrganizationDashBoardTimerId)
	AND
		OrganizationDashBoardTimer.OrganizationId = ISNULL(@OrganizationId, OrganizationDashBoardTimer.OrganizationId)
	AND
		OrganizationDashBoardTimer.DashBoardTimerTypeId = ISNULL(@DashBoardTimerTypeId, OrganizationDashBoardTimer.DashBoardTimerTypeId)				
	ORDER BY 1
GO

GRANT EXEC ON OrganizationDashBoardTimerSelect TO PUBLIC
GO
