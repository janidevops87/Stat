
		/******************************************************************************
		**	File: AspSourceCodeMap(Constraint).sql 
		**	Name: AspSourceCodeMap
		**	Desc: Creates the table AspSourceCodeMap
		**	Auth: ccarroll
		**	Date: 10/23/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/23/2009		ccarroll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table AspSourceCodeMap'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_AspSourceCodeMap')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_AspSourceCodeMap'
			ALTER TABLE dbo.AspSourceCodeMap ADD CONSTRAINT PK_AspSourceCodeMap PRIMARY KEY Clustered (AspSourceCodeMapId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_AspSourceCodeMap_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_AspSourceCodeMap_LastModified'
			ALTER TABLE dbo.AspSourceCodeMap ADD CONSTRAINT DF_AspSourceCodeMap_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE AspSourceCodeMap SET (LOCK_ESCALATION = TABLE)
		END

