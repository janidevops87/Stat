
		/******************************************************************************
		**	File: Credential(Constraint).sql 
		**	Name: Credential
		**	Desc: Creates the table Credential
		**	Auth: Bret Knoll
		**	Date: 9/14/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	9/14/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table Credential'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_Credential')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_Credential'
			ALTER TABLE dbo.Credential ADD CONSTRAINT PK_Credential PRIMARY KEY Clustered (CredentialId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_Credential_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_Credential_LastModified'
			ALTER TABLE dbo.Credential ADD CONSTRAINT DF_Credential_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE Credential SET (LOCK_ESCALATION = TABLE)
		END

