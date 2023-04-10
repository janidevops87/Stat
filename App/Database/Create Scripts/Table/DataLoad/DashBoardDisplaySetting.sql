 /***************************************************************************************************
**	Name: DashBoardDisplaySetting
**	Desc: Add Initial Data
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date		Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/25/2009	Bret Knoll		Initial Script Creation
**	07/09/2010	ccarroll		Added this note for development build (GenerateSQL)
**	09/06/2011	ccarroll		Added new base configuration settings
**	07/16/2014	ccarroll		Added base configuration for Organ Med RO CCRST175  		
***************************************************************************************************/

SET NOCOUNT ON

IF ((SELECT COUNT(*) FROM DashBoardDisplaySetting) = 0)
BEGIN
	PRINT 'Loading DashBoardDisplaySetting Data'
	
	INSERT INTO [DashBoardDisplaySetting]
           ([DashBoardDisplaySetting]
           ,[LastModified]
           ,[LastStatEmployeeId]
           ,[AuditLogTypeId])
     VALUES
           ('Display Pending Events Pop Up', GETDATE(), 45, 1),
           ('Display Callout Pending Events in Pending Pane', GETDATE(), 45, 1)
END

DECLARE @DashBoardDisplaySetting AS NVARCHAR(100)

/* Add DashboardDisplaySetting: Declared CTOD Update Functionality */
SET @DashBoardDisplaySetting = 'Declared CTOD Update Functionality'
IF NOT EXISTS (SELECT * FROM DashBoardDisplaySetting WHERE DashBoardDisplaySetting = @DashBoardDisplaySetting)
	BEGIN
		INSERT DashBoardDisplaySetting (DashBoardDisplaySetting, LastModified, LastStatEmployeeId, AuditLogTypeId)
				VALUES(@DashBoardDisplaySetting, GetDate(), 1100, 1)
	PRINT 'Adding DashBoardDisplaySetting: ' + @DashBoardDisplaySetting
	END

/* Add DashboardDisplaySetting: Organ Med RO Event Update Functionality */
SET @DashBoardDisplaySetting = 'Organ Med RO Event Update Functionality'
IF NOT EXISTS (SELECT * FROM DashBoardDisplaySetting WHERE DashBoardDisplaySetting = @DashBoardDisplaySetting)
	BEGIN
		INSERT DashBoardDisplaySetting (DashBoardDisplaySetting, LastModified, LastStatEmployeeId, AuditLogTypeId)
				VALUES(@DashBoardDisplaySetting, GetDate(), 1100, 1)
	PRINT 'Adding DashBoardDisplaySetting: ' + @DashBoardDisplaySetting
	END
