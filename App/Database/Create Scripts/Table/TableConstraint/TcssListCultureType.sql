/***************************************************************************************************
**	Name: TcssListCultureType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCultureType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCultureType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCultureType'
	ALTER TABLE dbo.TcssListCultureType ADD CONSTRAINT PK_TcssListCultureType PRIMARY KEY Clustered (TcssListCultureTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureType_LastUpdateDate'
	ALTER TABLE dbo.TcssListCultureType ADD CONSTRAINT DF_TcssListCultureType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureType_SortOrder'
	ALTER TABLE dbo.TcssListCultureType ADD CONSTRAINT DF_TcssListCultureType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureType_IsActive'
	ALTER TABLE dbo.TcssListCultureType ADD CONSTRAINT DF_TcssListCultureType_IsActive DEFAULT(1) FOR IsActive
END
GO
