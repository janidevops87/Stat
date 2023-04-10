/***************************************************************************************************
**	Name: TcssListDdavp
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDdavp
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDdavp')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDdavp'
	ALTER TABLE dbo.TcssListDdavp ADD CONSTRAINT PK_TcssListDdavp PRIMARY KEY Clustered (TcssListDdavpId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDdavp_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDdavp_LastUpdateDate'
	ALTER TABLE dbo.TcssListDdavp ADD CONSTRAINT DF_TcssListDdavp_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDdavp_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDdavp_SortOrder'
	ALTER TABLE dbo.TcssListDdavp ADD CONSTRAINT DF_TcssListDdavp_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDdavp_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDdavp_IsActive'
	ALTER TABLE dbo.TcssListDdavp ADD CONSTRAINT DF_TcssListDdavp_IsActive DEFAULT(1) FOR IsActive
END
GO
