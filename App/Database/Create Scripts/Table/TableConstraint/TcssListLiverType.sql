/***************************************************************************************************
**	Name: TcssListLiverType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListLiverType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListLiverType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListLiverType'
	ALTER TABLE dbo.TcssListLiverType ADD CONSTRAINT PK_TcssListLiverType PRIMARY KEY Clustered (TcssListLiverTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverType_LastUpdateDate'
	ALTER TABLE dbo.TcssListLiverType ADD CONSTRAINT DF_TcssListLiverType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverType_SortOrder'
	ALTER TABLE dbo.TcssListLiverType ADD CONSTRAINT DF_TcssListLiverType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLiverType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLiverType_IsActive'
	ALTER TABLE dbo.TcssListLiverType ADD CONSTRAINT DF_TcssListLiverType_IsActive DEFAULT(1) FOR IsActive
END
GO
