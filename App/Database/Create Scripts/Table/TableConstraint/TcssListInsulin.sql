/***************************************************************************************************
**	Name: TcssListInsulin
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListInsulin
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListInsulin')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListInsulin'
	ALTER TABLE dbo.TcssListInsulin ADD CONSTRAINT PK_TcssListInsulin PRIMARY KEY Clustered (TcssListInsulinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListInsulin_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListInsulin_LastUpdateDate'
	ALTER TABLE dbo.TcssListInsulin ADD CONSTRAINT DF_TcssListInsulin_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListInsulin_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListInsulin_SortOrder'
	ALTER TABLE dbo.TcssListInsulin ADD CONSTRAINT DF_TcssListInsulin_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListInsulin_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListInsulin_IsActive'
	ALTER TABLE dbo.TcssListInsulin ADD CONSTRAINT DF_TcssListInsulin_IsActive DEFAULT(1) FOR IsActive
END
GO
