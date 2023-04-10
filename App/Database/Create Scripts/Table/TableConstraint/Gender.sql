
		/******************************************************************************
		**	File: Gender(Constraint).sql 
		**	Name: Gender
		**	Desc: Creates the table Gender
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Gender'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Gender')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Gender'
			ALTER TABLE dbo.Gender ADD CONSTRAINT PK_Gender PRIMARY KEY Clustered (GenderId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Gender_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Gender_LastModified'
			ALTER TABLE dbo.Gender ADD CONSTRAINT DF_Gender_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Gender SET (LOCK_ESCALATION = TABLE)
		END

