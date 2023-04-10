/***************************************************************************************************
**	Name: TcssListTestType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListTestType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListTestType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListTestType'
	ALTER TABLE dbo.TcssListTestType ADD CONSTRAINT PK_TcssListTestType PRIMARY KEY Clustered (TcssListTestTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTestType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTestType_LastUpdateDate'
	ALTER TABLE dbo.TcssListTestType ADD CONSTRAINT DF_TcssListTestType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTestType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTestType_SortOrder'
	ALTER TABLE dbo.TcssListTestType ADD CONSTRAINT DF_TcssListTestType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListTestType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListTestType_IsActive'
	ALTER TABLE dbo.TcssListTestType ADD CONSTRAINT DF_TcssListTestType_IsActive DEFAULT(1) FOR IsActive
END
GO
