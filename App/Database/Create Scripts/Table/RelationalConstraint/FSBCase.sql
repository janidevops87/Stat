
		/******************************************************************************
		**	File: FSBCase(Relation).sql
		**	Name: AlterFSBCase
		**	Desc: Creates all the Foreign Key Relationships for the table FSBCase
		**	Auth: Bret Knoll
		**	Date: 7/13/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------		--------		-------------------------------------------
		**	7/13/2010		Bret Knoll		Initial Table Creation
		**									Addeded table to drop constraints and recreate with correct naming convention.
		*******************************************************************************/
	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FSBCase_SourceCodeId_SourceCode_SourceCodeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_FSBCase_SourceCodeId_SourceCode_SourceCodeId'
		ALTER TABLE dbo.FSBCase
			ADD CONSTRAINT FK_FSBCase_SourceCodeId_SourceCode_SourceCodeId FOREIGN KEY(SourceCodeId) REFERENCES dbo.SourceCode(SourceCodeId)
	END
	GO


	IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_FSBCase_FSBCaseTypeId_FSBCaseType_FSBCaseTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_FSBCase_FSBCaseTypeId_FSBCaseType_FSBCaseTypeId'
		ALTER TABLE dbo.FSBCase
			ADD CONSTRAINT FK_FSBCase_FSBCaseTypeId_FSBCaseType_FSBCaseTypeId FOREIGN KEY(FSBCaseTypeId) REFERENCES dbo.FSBCaseType(FSBCaseTypeId)
	END
	GO

		
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE FSBCase SET (LOCK_ESCALATION = TABLE)
		END
