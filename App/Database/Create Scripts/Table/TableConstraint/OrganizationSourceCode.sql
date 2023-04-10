
		/******************************************************************************
		**	File: OrganizationSourceCode(Constraint).sql 
		**	Name: OrganizationSourceCode
		**	Desc: Creates the table OrganizationSourceCode
		**	Auth: Bret Knoll
		**	Date: 11/12/2010
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	11/12/2010		Bret Knoll		Initial Table Creation
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table OrganizationSourceCode'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationSourceCode')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_OrganizationSourceCode'
			ALTER TABLE dbo.OrganizationSourceCode ADD CONSTRAINT PK_OrganizationSourceCode PRIMARY KEY Clustered (OrganizationId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationSourceCode_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_OrganizationSourceCode_LastModified'
			ALTER TABLE dbo.OrganizationSourceCode ADD CONSTRAINT DF_OrganizationSourceCode_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
	
		IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
		BEGIN
			ALTER TABLE OrganizationSourceCode SET (LOCK_ESCALATION = TABLE)
		END

