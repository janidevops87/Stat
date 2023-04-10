/***************************************************************************************************
**	Name: TcssListToxicologyScreen
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListToxicologyScreen
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListToxicologyScreen')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListToxicologyScreen'
	ALTER TABLE dbo.TcssListToxicologyScreen ADD CONSTRAINT PK_TcssListToxicologyScreen PRIMARY KEY Clustered (TcssListToxicologyScreenId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListToxicologyScreen_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListToxicologyScreen_LastUpdateDate'
	ALTER TABLE dbo.TcssListToxicologyScreen ADD CONSTRAINT DF_TcssListToxicologyScreen_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListToxicologyScreen_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListToxicologyScreen_SortOrder'
	ALTER TABLE dbo.TcssListToxicologyScreen ADD CONSTRAINT DF_TcssListToxicologyScreen_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListToxicologyScreen_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListToxicologyScreen_IsActive'
	ALTER TABLE dbo.TcssListToxicologyScreen ADD CONSTRAINT DF_TcssListToxicologyScreen_IsActive DEFAULT(1) FOR IsActive
END
GO
