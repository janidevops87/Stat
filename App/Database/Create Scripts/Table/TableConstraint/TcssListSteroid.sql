/***************************************************************************************************
**	Name: TcssListSteroid
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListSteroid
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListSteroid')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListSteroid'
	ALTER TABLE dbo.TcssListSteroid ADD CONSTRAINT PK_TcssListSteroid PRIMARY KEY Clustered (TcssListSteroidId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSteroid_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSteroid_LastUpdateDate'
	ALTER TABLE dbo.TcssListSteroid ADD CONSTRAINT DF_TcssListSteroid_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSteroid_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSteroid_SortOrder'
	ALTER TABLE dbo.TcssListSteroid ADD CONSTRAINT DF_TcssListSteroid_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSteroid_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSteroid_IsActive'
	ALTER TABLE dbo.TcssListSteroid ADD CONSTRAINT DF_TcssListSteroid_IsActive DEFAULT(1) FOR IsActive
END
GO
