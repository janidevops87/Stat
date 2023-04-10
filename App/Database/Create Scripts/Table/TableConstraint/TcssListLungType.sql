/***************************************************************************************************
**	Name: TcssListLungType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListLungType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListLungType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListLungType'
	ALTER TABLE dbo.TcssListLungType ADD CONSTRAINT PK_TcssListLungType PRIMARY KEY Clustered (TcssListLungTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLungType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLungType_LastUpdateDate'
	ALTER TABLE dbo.TcssListLungType ADD CONSTRAINT DF_TcssListLungType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLungType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLungType_SortOrder'
	ALTER TABLE dbo.TcssListLungType ADD CONSTRAINT DF_TcssListLungType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLungType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLungType_IsActive'
	ALTER TABLE dbo.TcssListLungType ADD CONSTRAINT DF_TcssListLungType_IsActive DEFAULT(1) FOR IsActive
END
GO
