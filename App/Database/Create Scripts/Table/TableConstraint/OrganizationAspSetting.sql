 /***************************************************************************************************
**	Name: OrganizationAspSetting
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationAspSetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationAspSetting')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationAspSetting'
	ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT PK_OrganizationAspSetting PRIMARY KEY Clustered (OrganizationAspSettingId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationAspSetting_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationAspSetting_LastModified'
	ALTER TABLE dbo.OrganizationAspSetting ADD CONSTRAINT DF_OrganizationAspSetting_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
