    /***************************************************************************************************
**	Name: TimeZone
**	Desc: Add Foreign keys to TimeZone
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	04/02/2009	Bret Knoll		Initial Key Creation 
**  07/14/10	Bret Knoll		Adding to release 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TimeZone_LastStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TimeZone_LastStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TimeZone ADD CONSTRAINT FK_TimeZone_LastStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TimeZone_AuditLogTypeId_AuditLogType_AuditLogTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TimeZone_AuditLogTypeId_AuditLogType_AuditLogTypeId'
		ALTER TABLE dbo.TimeZone ADD CONSTRAINT FK_TimeZone_AuditLogTypeId_AuditLogType_AuditLogTypeId
			FOREIGN KEY(AuditLogTypeId) REFERENCES dbo.AuditLogType(AuditLogTypeId) 
	END
GO



 