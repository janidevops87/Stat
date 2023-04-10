/***************************************************************************************************
**	Name: TcssListVentSettingMode
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListVentSettingMode
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListVentSettingMode')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListVentSettingMode'
	ALTER TABLE dbo.TcssListVentSettingMode ADD CONSTRAINT PK_TcssListVentSettingMode PRIMARY KEY Clustered (TcssListVentSettingModeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVentSettingMode_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVentSettingMode_LastUpdateDate'
	ALTER TABLE dbo.TcssListVentSettingMode ADD CONSTRAINT DF_TcssListVentSettingMode_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVentSettingMode_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVentSettingMode_SortOrder'
	ALTER TABLE dbo.TcssListVentSettingMode ADD CONSTRAINT DF_TcssListVentSettingMode_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVentSettingMode_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVentSettingMode_IsActive'
	ALTER TABLE dbo.TcssListVentSettingMode ADD CONSTRAINT DF_TcssListVentSettingMode_IsActive DEFAULT(1) FOR IsActive
END
GO
