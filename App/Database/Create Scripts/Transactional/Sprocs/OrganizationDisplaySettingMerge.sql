

IF EXISTS (Select * FROM sys.objects WHERE type = 'P' AND name = 'OrganizationDisplaySettingMerge')
	BEGIN
		PRINT 'Dropping Procedure OrganizationDisplaySettingMerge'
		DROP Procedure OrganizationDisplaySettingMerge
	END
GO

PRINT 'Creating Procedure OrganizationDisplaySettingMerge'
GO
CREATE Procedure OrganizationDisplaySettingMerge
(
		@OrganizationDisplaySettingId int = null,
		@OrganizationId int = null,
		@DashBoardDisplaySettingId int = null,
		@DashBoardDisplaySetting varchar(100) = null,
		@LastModified datetime = null,
		@LastStatEmployeeId int = null,
		@AuditLogTypeId int = null,
		@Hidden BIT = null										
)
AS
/******************************************************************************
**	File: OrganizationDisplaySettingMerge.sql
**	Name: OrganizationDisplaySettingMerge
**	Desc: Updates OrganizationDisplaySetting Based on Id field 
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

MERGE dbo.OrganizationDisplaySetting AS target
USING	(SELECT 
		@OrganizationDisplaySettingId, 
		@OrganizationId, 
		@DashBoardDisplaySettingId,
		@Hidden) AS source 
		(OrganizationDisplaySettingId, 
		OrganizationId, 
		DashBoardDisplaySettingId,
		Hidden)
ON		(target.OrganizationDisplaySettingId = source.OrganizationDisplaySettingId)
WHEN MATCHED AND source.Hidden = 1  THEN 
	UPDATE		
	SET 
			OrganizationId = @OrganizationId,
			DashBoardDisplaySettingId = @DashBoardDisplaySettingId,
			LastModified = GetDate(),
			LastStatEmployeeId = @LastStatEmployeeId,
			AuditLogTypeId = ISNULL(@AuditLogTypeId, 3) --- Modify;
WHEN MATCHED AND source.Hidden = 0  THEN 
	DELETE 			
WHEN NOT MATCHED AND source.Hidden = 1 THEN
	INSERT	
	(
		OrganizationId,
		DashBoardDisplaySettingId,
		LastModified,
		LastStatEmployeeId,
		AuditLogTypeId
	)
	VALUES
	(
		@OrganizationId,
		@DashBoardDisplaySettingId,
		GetDate(),
		@LastStatEmployeeId,
		1 --insert
	);
GO

GRANT EXEC ON OrganizationDisplaySettingMerge TO PUBLIC
GO
