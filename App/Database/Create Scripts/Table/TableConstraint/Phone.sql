
		/******************************************************************************
		**	File: Phone(Constraint).sql 
		**	Name: Phone
		**	Desc: Creates the table Phone
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
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Phone'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Phone')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Phone'
			ALTER TABLE dbo.Phone ADD CONSTRAINT PK_Phone PRIMARY KEY Clustered (PhoneId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Phone_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Phone_LastModified'
			ALTER TABLE dbo.Phone ADD CONSTRAINT DF_Phone_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Phone SET (LOCK_ESCALATION = TABLE)
		END

