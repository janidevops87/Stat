
		/******************************************************************************
		**	File: SecurityRule(Constraint).sql 
		**	Name: SecurityRule
		**	Desc: Creates the table SecurityRule
		**	Auth: Bret Knoll
		**	Date: 9/4/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	9/4/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table SecurityRule'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SecurityRule')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_SecurityRule'
			ALTER TABLE dbo.SecurityRule ADD CONSTRAINT PK_SecurityRule PRIMARY KEY Clustered (SecurityRuleId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SecurityRule_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_SecurityRule_LastModified'
			ALTER TABLE dbo.SecurityRule ADD CONSTRAINT DF_SecurityRule_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE SecurityRule SET (LOCK_ESCALATION = TABLE)
		END

