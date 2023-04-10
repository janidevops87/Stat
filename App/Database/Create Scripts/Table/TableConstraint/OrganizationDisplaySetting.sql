 /***************************************************************************************************
**	Name: OrganizationDisplaySetting
**	Desc: Add Primary keys, Unique keys, and Default Keys to OrganizationDisplaySetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation 
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_OrganizationDisplaySetting')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_OrganizationDisplaySetting'
	ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT PK_OrganizationDisplaySetting PRIMARY KEY Clustered (OrganizationDisplaySettingId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_OrganizationDisplaySetting_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_OrganizationDisplaySetting_LastModified'
	ALTER TABLE dbo.OrganizationDisplaySetting ADD CONSTRAINT DF_OrganizationDisplaySetting_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
