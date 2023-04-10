/***************************************************************************************************
**	Name: TcssListKidneyCystsDiscoloration
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyCystsDiscoloration
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyCystsDiscoloration')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyCystsDiscoloration'
	ALTER TABLE dbo.TcssListKidneyCystsDiscoloration ADD CONSTRAINT PK_TcssListKidneyCystsDiscoloration PRIMARY KEY Clustered (TcssListKidneyCystsDiscolorationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCystsDiscoloration_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCystsDiscoloration_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyCystsDiscoloration ADD CONSTRAINT DF_TcssListKidneyCystsDiscoloration_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCystsDiscoloration_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCystsDiscoloration_SortOrder'
	ALTER TABLE dbo.TcssListKidneyCystsDiscoloration ADD CONSTRAINT DF_TcssListKidneyCystsDiscoloration_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyCystsDiscoloration_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyCystsDiscoloration_IsActive'
	ALTER TABLE dbo.TcssListKidneyCystsDiscoloration ADD CONSTRAINT DF_TcssListKidneyCystsDiscoloration_IsActive DEFAULT(1) FOR IsActive
END
GO
