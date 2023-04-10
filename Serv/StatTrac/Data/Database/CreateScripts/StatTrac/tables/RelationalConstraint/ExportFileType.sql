/******************************************************************************
**	File: ExportFileType.sql
**	Name: ExportFileType
**	Desc: Relational Constraints for ExportFileType
**	Auth: Bret Knoll
**	Date: 02/26/2009
*******************************************************************************
**	Change History
*******************************************************************************
**	Date:		Author:			Description:
**	--------	--------		-------------------------------------------
**	02/26/2009	Bret Knoll	Initial Relational Constraints
*******************************************************************************/

PRINT 'Drop All Foreign Keys to ExportFileType'
WHILE EXISTS(SELECT * FROM sysobjects WHERE id = 
				(SELECT MAX(constid) FROM sysforeignkeys WHERE Fkeyid = 
					(SELECT Id FROM sysobjects WHERE name = 'ExportFileType')))
BEGIN
	DECLARE @sqlScript nvarchar(500), @TableNameId int, @FkId int, @KeyId int, 
		@FkTableName varchar(500), @KeyName varchar(500)

	SELECT @TableNameId = Id FROM sysobjects WHERE name = 'ExportFileType'
	SELECT @FkId = fkeyid, @KeyId = constid FROM sysforeignkeys WHERE Fkeyid = @TableNameId
	SELECT @FkTableName = name FROM sysobjects WHERE id = @FkId
	SELECT @KeyName = name FROM sysobjects WHERE id = @KeyId
	
	SET @sqlScript = 'ALTER TABLE ' + @FkTableName + ' DROP CONSTRAINT ' + @KeyName
	EXEC(@sqlScript)
END

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFileType_ExportFileDataType')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFileType_ExportFileDataType'
		ALTER TABLE dbo.ExportFileType ADD CONSTRAINT
			FK_ExportFileType_ExportFileDataType FOREIGN KEY
			(
			ExportFileDataTypeID
			) REFERENCES dbo.ExportFileDataType
			(
			ExportFileDataTypeID
			)
	END
GO



IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_ExportFileType_ExportFileXslt')
	BEGIN
		PRINT 'Adding Foreign Key FK_ExportFileType_ExportFileXslt'
		ALTER TABLE dbo.ExportFileType ADD CONSTRAINT
			FK_ExportFileType_ExportFileXslt FOREIGN KEY
			(
			ExportFileXsltID
			) REFERENCES dbo.ExportFileXslt
			(
			ExportFileXsltID
			)
	END
GO
