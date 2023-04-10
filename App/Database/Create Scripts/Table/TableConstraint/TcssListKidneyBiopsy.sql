/***************************************************************************************************
**	Name: TcssListKidneyBiopsy
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyBiopsy')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyBiopsy'
	ALTER TABLE dbo.TcssListKidneyBiopsy ADD CONSTRAINT PK_TcssListKidneyBiopsy PRIMARY KEY Clustered (TcssListKidneyBiopsyId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyBiopsy_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyBiopsy_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyBiopsy ADD CONSTRAINT DF_TcssListKidneyBiopsy_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyBiopsy_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyBiopsy_SortOrder'
	ALTER TABLE dbo.TcssListKidneyBiopsy ADD CONSTRAINT DF_TcssListKidneyBiopsy_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyBiopsy_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyBiopsy_IsActive'
	ALTER TABLE dbo.TcssListKidneyBiopsy ADD CONSTRAINT DF_TcssListKidneyBiopsy_IsActive DEFAULT(1) FOR IsActive
END
GO
