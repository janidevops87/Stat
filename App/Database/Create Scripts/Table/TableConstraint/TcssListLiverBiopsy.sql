/***************************************************************************************************
**	Name: TcssListLiverBiopsy
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListLiverBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListLiverBiopsy')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListLiverBiopsy'
	ALTER TABLE dbo.TcssListLiverBiopsy ADD CONSTRAINT PK_TcssListLiverBiopsy PRIMARY KEY Clustered (TcssListLiverBiopsyId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverBiopsy_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverBiopsy_LastUpdateDate'
	ALTER TABLE dbo.TcssListLiverBiopsy ADD CONSTRAINT DF_TcssListLiverBiopsy_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverBiopsy_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverBiopsy_SortOrder'
	ALTER TABLE dbo.TcssListLiverBiopsy ADD CONSTRAINT DF_TcssListLiverBiopsy_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverBiopsy_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverBiopsy_IsActive'
	ALTER TABLE dbo.TcssListLiverBiopsy ADD CONSTRAINT DF_TcssListLiverBiopsy_IsActive DEFAULT(1) FOR IsActive
END
GO
