/***************************************************************************************************
**	Name: TcssListKidneyCapsularTear
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyCapsularTear
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyCapsularTear')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyCapsularTear'
	ALTER TABLE dbo.TcssListKidneyCapsularTear ADD CONSTRAINT PK_TcssListKidneyCapsularTear PRIMARY KEY Clustered (TcssListKidneyCapsularTearId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCapsularTear_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCapsularTear_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyCapsularTear ADD CONSTRAINT DF_TcssListKidneyCapsularTear_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCapsularTear_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCapsularTear_SortOrder'
	ALTER TABLE dbo.TcssListKidneyCapsularTear ADD CONSTRAINT DF_TcssListKidneyCapsularTear_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCapsularTear_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCapsularTear_IsActive'
	ALTER TABLE dbo.TcssListKidneyCapsularTear ADD CONSTRAINT DF_TcssListKidneyCapsularTear_IsActive DEFAULT(1) FOR IsActive
END
GO
