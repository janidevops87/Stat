  /***************************************************************************************************
**	Name: OrganizationDashBoardTimer
**	Desc: Add Foreign keys to OrganizationDashBoardTimer
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDashBoardTimer_OrganizationId_Organization_OrganizationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDashBoardTimer_OrganizationId_Organization_OrganizationId'
		ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT FK_OrganizationDashBoardTimer_OrganizationId_Organization_OrganizationId
			FOREIGN KEY(OrganizationId) REFERENCES dbo.Organization(OrganizationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDashBoardTimer_DashBoardTimerTypeId_DashBoardTimerType_DashBoardTimerTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDashBoardTimer_DashBoardTimerTypeId_DashBoardTimerType_DashBoardTimerTypeId'
		ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT FK_OrganizationDashBoardTimer_DashBoardTimerTypeId_DashBoardTimerType_DashBoardTimerTypeId
			FOREIGN KEY(DashBoardTimerTypeId) REFERENCES dbo.DashBoardTimerType(DashBoardTimerTypeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDashBoardTimer_DashBoardWindowId_DashBoardWindow_DashBoardWindowId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDashBoardTimer_DashBoardWindowId_DashBoardWindow_DashBoardWindowId'
		ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT FK_OrganizationDashBoardTimer_DashBoardWindowId_DashBoardWindow_DashBoardWindowId
			FOREIGN KEY(DashBoardWindowId) REFERENCES dbo.DashBoardWindow(DashBoardWindowId) 
	END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDashBoardTimer_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDashBoardTimer_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT FK_OrganizationDashBoardTimer_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_OrganizationDashBoardTimer_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_OrganizationDashBoardTimer_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.OrganizationDashBoardTimer ADD CONSTRAINT FK_OrganizationDashBoardTimer_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 