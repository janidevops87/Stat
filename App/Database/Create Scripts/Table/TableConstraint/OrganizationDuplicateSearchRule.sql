 /***************************************************************************************************
**	Name: OrganizationDuplicateSearchRule
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationDuplicateSearchRule
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationDuplicateSearchRule')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationDuplicateSearchRule'
	ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT PK_OrganizationDuplicateSearchRule PRIMARY KEY Clustered (OrganizationDuplicateSearchRuleId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationDuplicateSearchRule_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationDuplicateSearchRule_LastModified'
	ALTER TABLE dbo.OrganizationDuplicateSearchRule ADD CONSTRAINT DF_OrganizationDuplicateSearchRule_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
