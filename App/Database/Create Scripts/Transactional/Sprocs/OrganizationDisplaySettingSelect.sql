

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDisplaySettingSelect')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDisplaySettingSelect'
		DROP Procedure OrganizationDisplaySettingSelect
	END
GO

PRINT 'Creating Procedure OrganizationDisplaySettingSelect'
GO
CREATE Procedure OrganizationDisplaySettingSelect
(
		@OrganizationId int = null
)
AS
/******************************************************************************
**	File: OrganizationDisplaySettingSelect.sql
**	Name: OrganizationDisplaySettingSelect
**	Desc: Selects multiple rows of OrganizationDisplaySetting Based on Id  fields 
**	Auth: Bret Knoll
**	Date: 7/13/2009
**	Called By: 
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:			Author:					Description:
**	--------		--------				----------------------------------
**	7/13/2009		Bret Knoll			Initial Sproc Creation
**	07/12/2010		ccarroll			added this note for development build (GenerateSQL)
*******************************************************************************/
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
	SET NOCOUNT ON; 
With OrganizationDisplaySettingTable (OrganizationDisplaySettingId, OrganizationID, DashBoardDisplaySettingId, DashBoardDisplaySetting, LastModified, LastStatEmployeeID, AuditLogTypeID, HIDDEN )
AS
(
	-- Select the selected Items
	-- These are items the organization belongs too.
	-- Set the required Hidden column equal to 0
	SELECT     
			CONVERT(INTEGER, '-' + CONVERT(VARCHAR(15), DashBoardDisplaySetting.DashBoardDisplaySettingId)  + CONVERT(VARCHAR(15), Organization.OrganizationID)) AS OrganizationDisplaySettingId,
			Organization.OrganizationId AS OrganizationID,
			DashBoardDisplaySetting.DashBoardDisplaySettingId,
			DashBoardDisplaySetting AS DashBoardDisplaySetting,			
			GETDATE() AS LastModified,
			-1 AS LastStatEmployeeID,
			1 AS AuditLogTypeID,
			0 AS 'HIDDEN'
	
	FROM 
		Organization, DashBoardDisplaySetting 
	WHERE 	
		OrganizationID = @OrganizationId	
)

	SELECT
		COALESCE(OrganizationDisplaySetting.OrganizationDisplaySettingID, OrganizationDisplaySettingTable.OrganizationDisplaySettingID) OrganizationDisplaySettingID,
		OrganizationDisplaySettingTable.OrganizationID,
		OrganizationDisplaySettingTable.DashBoardDisplaySettingId,
		OrganizationDisplaySettingTable.DashBoardDisplaySetting,
		COALESCE(OrganizationDisplaySetting.LastModified, OrganizationDisplaySettingTable.LastModified) LastModified,
		COALESCE(OrganizationDisplaySetting.LastStatEmployeeID, OrganizationDisplaySettingTable.LastStatEmployeeID) LastStatEmployeeID,
		COALESCE(OrganizationDisplaySetting.AuditLogTypeID, OrganizationDisplaySettingTable.AuditLogTypeID) AuditLogTypeID,
		CASE WHEN OrganizationDisplaySetting.OrganizationDisplaySettingID > 0 THEN 1 ELSE 0 END 'HIDDEN'
		
	FROM
		OrganizationDisplaySettingTable 
	LEFT JOIN
		OrganizationDisplaySetting ON OrganizationDisplaySettingTable.OrganizationID = OrganizationDisplaySetting.OrganizationId
		AND OrganizationDisplaySettingTable.DashBoardDisplaySettingId = OrganizationDisplaySetting.DashBoardDisplaySettingId
		
	---- Add any unselected items
	---- These are items in the list the organization does not belong to
	---- Set the required Hidden column equal to 1			
	--INSERT #TEMPOrganizationDisplaySetting
	--SELECT     
	--		NULL, -- THIS IS NULL BECAUSE THE VALUE DOES NOT EXIST
	--		@OrganizationId AS OrganizationID,
	--		DashBoardDisplaySetting.DashBoardDisplaySettingId,
	--		DashBoardDisplaySetting AS DashBoardDisplaySetting,
	--		COALESCE(OrganizationDisplaySetting.LastModified, GETDATE()) AS LastModified,
	--		COALESCE(OrganizationDisplaySetting.LastStatEmployeeId, -1) AS LastStatEmployeeID,
	--		COALESCE(OrganizationDisplaySetting.AuditLogTypeId, 1) AS AuditLogTypeID,
	--		1 AS 'Hidden'
	--FROM 
	--	DashBoardDisplaySetting 
	--LEFT JOIN
	--	OrganizationDisplaySetting ON DashBoardDisplaySetting.DashBoardDisplaySettingId = OrganizationDisplaySetting.DashBoardDisplaySettingId
	--	AND OrganizationDisplaySetting.OrganizationId = @OrganizationId
	--WHERE 	
	--	(
	--	OrganizationDisplaySetting.OrganizationId = @OrganizationId
	--	OR
	--	DashBoardDisplaySetting.DashBoardDisplaySettingId = DashBoardDisplaySetting.DashBoardDisplaySettingId
	--	)
	--	AND
	--	@OrganizationId > 0

		
	---- Select the temp table
	--SELECT 	COALESCE(OrganizationDisplaySettingId, IDCOLUMN) OrganizationDisplaySettingId,
	--		OrganizationID,
	--		DashBoardDisplaySettingId,
	--		DashBoardDisplaySetting,
	--		LastModified,
	--		LastStatEmployeeID,
	--		AuditLogTypeID,
	--		HIDDEN
	--FROM #TEMPOrganizationDisplaySetting
	
	--DROP TABLE #TEMPOrganizationDisplaySetting

GO

GRANT EXEC ON OrganizationDisplaySettingSelect TO PUBLIC
GO
