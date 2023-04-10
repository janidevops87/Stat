/***************************************************************************************************
**	Name: TcssListDiuretic
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDiuretic
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDiuretic')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDiuretic'
	ALTER TABLE dbo.TcssListDiuretic ADD CONSTRAINT PK_TcssListDiuretic PRIMARY KEY Clustered (TcssListDiureticId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiuretic_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiuretic_LastUpdateDate'
	ALTER TABLE dbo.TcssListDiuretic ADD CONSTRAINT DF_TcssListDiuretic_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiuretic_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiuretic_SortOrder'
	ALTER TABLE dbo.TcssListDiuretic ADD CONSTRAINT DF_TcssListDiuretic_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDiuretic_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDiuretic_IsActive'
	ALTER TABLE dbo.TcssListDiuretic ADD CONSTRAINT DF_TcssListDiuretic_IsActive DEFAULT(1) FOR IsActive
END
GO
