
		/******************************************************************************
		**	File: PersonPhone(Constraint).sql 
		**	Name: PersonPhone
		**	Desc: Creates the table PersonPhone
		**	Auth: Bret Knoll
		**	Date: 10/6/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	10/6/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table PersonPhone'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_PersonPhone_1__13')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_PersonPhone_1__13'
			ALTER TABLE dbo.PersonPhone ADD CONSTRAINT PK_PersonPhone_1__13 PRIMARY KEY Clustered (PersonPhoneId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_PersonPhone_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_PersonPhone_LastModified'
			ALTER TABLE dbo.PersonPhone ADD CONSTRAINT DF_PersonPhone_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE PersonPhone SET (LOCK_ESCALATION = TABLE)
		END

