   /***************************************************************************************************
**	Name: DashBoardDisplaySetting
**	Desc: Add Foreign keys to DashBoardDisplaySetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DashBoardDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_DashBoardDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.DashBoardDisplaySetting ADD CONSTRAINT FK_DashBoardDisplaySetting_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_DashBoardDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_DashBoardDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.DashBoardDisplaySetting ADD CONSTRAINT FK_DashBoardDisplaySetting_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 