 /***************************************************************************************************
**	Name: SourceCodeOrganization
**	Desc: Add Primary keys, Unique keys, and Default Keys to SourceCodeOrganization
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	10/23/2009	ccarroll	Updated key names (my generation) standard 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
*******************************************************************************/
	-- Alter the table to  Defaults, Primary Keys and Indexes 
	PRINT 'Add Primary Keys, Indexes and Defaults for Table SourceCodeOrganization'
	GO
	IF EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK___2__15')
	BEGIN
		PRINT 'DROP CONSTRAINT PK___2__15'
		ALTER TABLE dbo.SourceCodeOrganization
			DROP CONSTRAINT PK___2__15
	END

	GO
	IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_SourceCodeOrganization')
	BEGIN
		PRINT 'Creating Primary Key Constraint PK_SourceCodeOrganization'
		ALTER TABLE dbo.SourceCodeOrganization ADD CONSTRAINT PK_SourceCodeOrganization PRIMARY KEY Clustered (SourceCodeOrganizationId) 
	END
	GO

	IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_SourceCodeOrganization_LastModified')
	BEGIN
		PRINT 'Creating Default Constraint DF_SourceCodeOrganization_LastModified'
		ALTER TABLE dbo.SourceCodeOrganization ADD CONSTRAINT DF_SourceCodeOrganization_LastModified DEFAULT(GetDate()) FOR LastModified
	END
	GO

	IF (SERVERPROPERTY ( 'ProductVersion' ) = '10.0.2531.0')
	BEGIN
		ALTER TABLE SourceCodeOrganization SET (LOCK_ESCALATION = TABLE)
	END

