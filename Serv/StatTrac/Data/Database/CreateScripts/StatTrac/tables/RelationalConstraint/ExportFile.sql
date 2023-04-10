/******************************************************************************
**	File: ExportFile.sql
**	Name: ExportFile
**	Desc: Relational Constraints for ExportFile
**	Auth: Bret Knoll
**	Date: 02/26/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	02/26/2009	Bret Knoll	Initial Relational Constraints
*******************************************************************************/

PRINT 'Drop All Foreign Keys to ExportFile'
WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
				(SELECT MAX(constid) FROM sysforeignkeys WHERE Fkeyid = 
					(SELECT Id FROM sysobjects WHERE name = 'ExportFile')))
BEGIN
	DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
		@FkTableName varchar(500), @KeyName varchar(500)

	SELECT @TableNameId = Id FROM sysobjects WHERE name = 'ExportFile'
	SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE Fkeyid = @TableNameId
	SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
	SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
	
	SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
	EXEC(@sqlScript)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFile_ExportFileType')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFile_ExportFileType'
		ALTER TABLE dbo.ExportFile ADD CONSTRAINT
			FK_ExportFile_ExportFileType FOREIGN KEY
			(
			ExportFileTypeID
			) REFERENCES dbo.ExportFileType
			(
			ExportFileTypeID
			)
	END
GO
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFile_CloseCaseTrigger')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFile_CloseCaseTrigger'
		ALTER TABLE dbo.ExportFile ADD CONSTRAINT
			FK_ExportFile_CloseCaseTrigger FOREIGN KEY
			(
			CloseCaseTriggerID
			) REFERENCES dbo.CloseCaseTrigger
			(
			CloseCaseTriggerID
			)

	END
IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFile_StatEmployee')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFile_StatEmployee'
		ALTER TABLE dbo.ExportFile ADD CONSTRAINT
			FK_ExportFile_StatEmployee FOREIGN KEY
			(
			LastStatEmployeeID
			) REFERENCES dbo.StatEmployee
			(
			StatEmployeeID
			)		

	END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFile_AuditLogType')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFile_AuditLogType'
		ALTER TABLE dbo.ExportFile ADD CONSTRAINT
			FK_ExportFile_AuditLogType FOREIGN KEY
			(
			AuditLogTypeID
			) REFERENCES dbo.AuditLogType
			(
			AuditLogTypeId
			)
	END
GO


IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFile_Organization')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFile_Organization'
		ALTER TABLE dbo.ExportFile ADD CONSTRAINT
			FK_ExportFile_Organization FOREIGN KEY
			(
			OrganizationID
			) REFERENCES dbo.Organization
			(
			OrganizationID
			)

	END
GO


