 /***************************************************************************************************
**	Name: DashBoardDisplaySetting
**	Desc: Add Primary keys, Unique keys, and Default Keys to DashBoardDisplaySetting
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	6/19/2009	Bret Knoll	Initial Key Creation
**	07/09/2010	ccarroll		added this note for development build (GenerateSQL)
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_DashBoardDisplaySetting')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_DashBoardDisplaySetting'
	ALTER TABLE dbo.DashBoardDisplaySetting ADD CONSTRAINT PK_DashBoardDisplaySetting PRIMARY KEY Clustered (DashBoardDisplaySettingId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_DashBoardDisplaySetting_LastModified')
BEGIN
	PRINT 'Creating Default Constraint DF_DashBoardDisplaySetting_LastModified'
	ALTER TABLE dbo.DashBoardDisplaySetting ADD CONSTRAINT DF_DashBoardDisplaySetting_LastModified DEFAULT(GetDate()) FOR LastModified
END
GO
