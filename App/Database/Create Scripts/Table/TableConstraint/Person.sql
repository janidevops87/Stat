
		/******************************************************************************
		**	File: Person(Constraint).sql 
		**	Name: Person
		**	Desc: Creates the table Person
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Person'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Person')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Person'
			ALTER TABLE dbo.Person ADD CONSTRAINT PK_Person PRIMARY KEY Clustered (PersonId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Person_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Person_LastModified'
			ALTER TABLE dbo.Person ADD CONSTRAINT DF_Person_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Person SET (LOCK_ESCALATION = TABLE)
		END

