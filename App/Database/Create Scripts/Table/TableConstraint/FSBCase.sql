
		/******************************************************************************
		**	File: FSBCase(Constraint).sql 
		**	Name: FSBCase
		**	Desc: Creates the table FSBCase
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
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table FSBCase'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_FSBCase')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_FSBCase'
			ALTER TABLE dbo.FSBCase ADD CONSTRAINT PK_FSBCase PRIMARY KEY Clustered (FSBCaseId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_FSBCase_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_FSBCase_LastModified'
			ALTER TABLE dbo.FSBCase ADD CONSTRAINT DF_FSBCase_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE FSBCase SET (LOCK_ESCALATION = TABLE)
		END

