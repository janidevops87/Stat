
		/******************************************************************************
		**	File: Field(Constraint).sql 
		**	Name: Field
		**	Desc: Creates the table Field
		**	Auth: Bret Knoll
		**	Date: 12/7/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	12/7/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Field'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Field')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Field'
			ALTER TABLE dbo.Field ADD CONSTRAINT PK_Field PRIMARY KEY Clustered (FieldId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Field_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Field_LastModified'
			ALTER TABLE dbo.Field ADD CONSTRAINT DF_Field_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Field SET (LOCK_ESCALATION = TABLE)
		END

