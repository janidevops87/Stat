
		/******************************************************************************
		**	File: PersonType(Constraint).sql 
		**	Name: PersonType
		**	Desc: Creates the table PersonType
		**	Auth: Bret Knoll
		**	Date: 9/15/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	9/15/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table PersonType'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_PersonType')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_PersonType'
			ALTER TABLE dbo.PersonType ADD CONSTRAINT PK_PersonType PRIMARY KEY Clustered (PersonTypeId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_PersonType_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_PersonType_LastModified'
			ALTER TABLE dbo.PersonType ADD CONSTRAINT DF_PersonType_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PersonType SET (LOCK_ESCALATION = TABLE)
		END

