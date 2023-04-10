 /***************************************************************************************************
**	Name: OrganizationFsSourceCode
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationFsSourceCode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationFsSourceCode')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationFsSourceCode'
	ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT PK_OrganizationFsSourceCode PRIMARY KEY Clustered (OrganizationFsSourceCodeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationFsSourceCode_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationFsSourceCode_LastModified'
	ALTER TABLE dbo.OrganizationFsSourceCode ADD CONSTRAINT DF_OrganizationFsSourceCode_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
