
		/******************************************************************************
		**	File: EmailType(Constraint).sql 
		**	Name: EmailType
		**	Desc: Creates the table EmailType
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table EmailType'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_EmailType')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_EmailType'
			ALTER TABLE dbo.EmailType ADD CONSTRAINT PK_EmailType PRIMARY KEY Clustered (EmailTypeId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_EmailType_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_EmailType_LastModified'
			ALTER TABLE dbo.EmailType ADD CONSTRAINT DF_EmailType_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE EmailType SET (LOCK_ESCALATION = TABLE)
		END

