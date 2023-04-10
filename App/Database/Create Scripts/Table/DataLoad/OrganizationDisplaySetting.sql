
 /***************************************************************************************************
**	Name: OrganizationDisplaySetting
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/
-- SELECT * FROM ORGANIZATION WHERE ORGANIZATIONnAME LIKE 'OH- LI%'

  
DECLARE @OrganizationID INT = 5115

IF NOT EXISTS (SELECT * FROM OrganizationDisplaySetting WHERE organizationID = @OrganizationID )
BEGIN
	PRINT 'Loading OrganizationDisplaySetting Data'
	DECLARE 
		@DashBoardDisplaySettingid INT =  2,	--Display Callout Pending Events in Pending Pane	
		@LastModified	datetime ,
		@LastStatEmployeeId	int = 45,
		@AuditLogTypeId	int = 1

		SET @LastModified = GetDate()
	
	EXEC OrganizationDisplaySettingInsert  
		@OrganizationID = @OrganizationID, 
		@DashBoardDisplaySettingid = @DashBoardDisplaySettingid,
		@LastModified				=@LastModified	,			
		@LastStatEmployeeId			=@LastStatEmployeeId	,			
		@AuditLogTypeId				=@AuditLogTypeId					


END
GO
DECLARE @OrganizationID INT = 14019

IF NOT EXISTS (SELECT * FROM OrganizationDisplaySetting WHERE organizationID = @OrganizationID )
BEGIN
	PRINT 'Loading OrganizationDisplaySetting Data'
	DECLARE 
		@DashBoardDisplaySettingid INT =  2,	--Display Callout Pending Events in Pending Pane	
		@LastModified	datetime ,
		@LastStatEmployeeId	int = 45,
		@AuditLogTypeId	int = 1

		SET @LastModified = GetDate()
	
	EXEC OrganizationDisplaySettingInsert  
		@OrganizationID = @OrganizationID, 
		@DashBoardDisplaySettingid = @DashBoardDisplaySettingid,
		@LastModified				=@LastModified	,			
		@LastStatEmployeeId			=@LastStatEmployeeId	,			
		@AuditLogTypeId				=@AuditLogTypeId					


END
GO
DECLARE @OrganizationID INT = 2309

IF NOT EXISTS (SELECT * FROM OrganizationDisplaySetting WHERE organizationID = @OrganizationID )
BEGIN
	PRINT 'Loading OrganizationDisplaySetting Data'
	DECLARE 
		@DashBoardDisplaySettingid INT =  2,	--Display Callout Pending Events in Pending Pane	
		@LastModified	datetime ,
		@LastStatEmployeeId	int = 45,
		@AuditLogTypeId	int = 1

		SET @LastModified = GetDate()
	
	EXEC OrganizationDisplaySettingInsert  
		@OrganizationID = @OrganizationID, 
		@DashBoardDisplaySettingid = @DashBoardDisplaySettingid,
		@LastModified				=@LastModified	,			
		@LastStatEmployeeId			=@LastStatEmployeeId	,			
		@AuditLogTypeId				=@AuditLogTypeId					


END
GO
DECLARE @OrganizationID INT = 2257

IF NOT EXISTS (SELECT * FROM OrganizationDisplaySetting WHERE organizationID = @OrganizationID )
BEGIN
	PRINT 'Loading OrganizationDisplaySetting Data'
	DECLARE 
		@DashBoardDisplaySettingid INT =  2,	--Display Callout Pending Events in Pending Pane	
		@LastModified	datetime ,
		@LastStatEmployeeId	int = 45,
		@AuditLogTypeId	int = 1

		SET @LastModified = GetDate()
	
	EXEC OrganizationDisplaySettingInsert  
		@OrganizationID = @OrganizationID, 
		@DashBoardDisplaySettingid = @DashBoardDisplaySettingid,
		@LastModified				=@LastModified	,			
		@LastStatEmployeeId			=@LastStatEmployeeId	,			
		@AuditLogTypeId				=@AuditLogTypeId					


END
GO
DECLARE @OrganizationID INT = 1100

IF NOT EXISTS (SELECT * FROM OrganizationDisplaySetting WHERE organizationID = @OrganizationID )
BEGIN
	PRINT 'Loading OrganizationDisplaySetting Data'
	DECLARE 
		@DashBoardDisplaySettingid INT =  2,	--Display Callout Pending Events in Pending Pane	
		@LastModified	datetime ,
		@LastStatEmployeeId	int = 45,
		@AuditLogTypeId	int = 1

		SET @LastModified = GetDate()
	
	EXEC OrganizationDisplaySettingInsert  
		@OrganizationID = @OrganizationID, 
		@DashBoardDisplaySettingid = @DashBoardDisplaySettingid,
		@LastModified				=@LastModified	,			
		@LastStatEmployeeId			=@LastStatEmployeeId	,			
		@AuditLogTypeId				=@AuditLogTypeId					


END
GO