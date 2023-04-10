
		/******************************************************************************
		**	File: OrganizationPhone.sql 
		**	Name: OrganizationPhone
		**	Desc: Creates the table OrganizationPhone
		**	Auth: Bret Knoll
		**	Date: 7/13/2009
		*******************************************************************************
		**	Change History
		*******************************************************************************
		**	Date:			Author:			Description:
		**	--------			--------			-------------------------------------------
		**	7/13/2009		Bret Knoll		Initial Table Creation
		**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
		*******************************************************************************/
		-- Alter the table to  Defaults, Primary Keys and Indexes 
		PRINT 'Add Primary Keys, Indexes and Defaults for Table OrganizationPhone'
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationPhone')
		BEGIN
			PRINT 'Creating Primary Key Constraint PK_OrganizationPhone'
			ALTER TABLE dbo.OrganizationPhone ADD CONSTRAINT PK_OrganizationPhone PRIMARY KEY Clustered (OrganizationPhoneId) 
		END
		GO

		IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationPhone_LastModified')
		BEGIN
			PRINT 'Creating Default Constraint DF_OrganizationPhone_LastModified'
			ALTER TABLE dbo.OrganizationPhone ADD CONSTRAINT DF_OrganizationPhone_LastModified DEFAULT(GetDate()) FOR LastModified
		END
		GO
		
		
	if (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0') BEGIN ALTER TABLE OrganizationPhone SET (LOCK_ESCALATION = TABLE) END	
