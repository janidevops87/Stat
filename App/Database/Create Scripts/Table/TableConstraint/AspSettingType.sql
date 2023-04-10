 /***************************************************************************************************
**	Name: AspSettingType
**	Desc: Add Primary keys, Unique keys, and Default Keys to AspSettingType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/


IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_AspSettingType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_AspSettingType'
	ALTER TABLE dbo.AspSettingType ADD CONSTRAINT PK_AspSettingType PRIMARY KEY Clustered (AspSettingTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_AspSettingType_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_AspSettingType_LastModified'
	ALTER TABLE dbo.AspSettingType ADD CONSTRAINT DF_AspSettingType_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
