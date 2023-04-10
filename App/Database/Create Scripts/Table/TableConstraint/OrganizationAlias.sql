 /***************************************************************************************************
**	Name: OrganizationAlias
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationAlias
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationAlias')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationAlias'
	ALTER TABLE dbo.OrganizationAlias ADD CONSTRAINT PK_OrganizationAlias PRIMARY KEY Clustered (OrganizationAliasId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationAlias_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationAlias_LastModified'
	ALTER TABLE dbo.OrganizationAlias ADD CONSTRAINT DF_OrganizationAlias_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
