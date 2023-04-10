/***************************************************************************************************
**	Name: TcssListKidneyFatCleaned
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneyFatCleaned
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneyFatCleaned')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneyFatCleaned'
	ALTER TABLE dbo.TcssListKidneyFatCleaned ADD CONSTRAINT PK_TcssListKidneyFatCleaned PRIMARY KEY Clustered (TcssListKidneyFatCleanedId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFatCleaned_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFatCleaned_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneyFatCleaned ADD CONSTRAINT DF_TcssListKidneyFatCleaned_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFatCleaned_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFatCleaned_SortOrder'
	ALTER TABLE dbo.TcssListKidneyFatCleaned ADD CONSTRAINT DF_TcssListKidneyFatCleaned_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneyFatCleaned_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneyFatCleaned_IsActive'
	ALTER TABLE dbo.TcssListKidneyFatCleaned ADD CONSTRAINT DF_TcssListKidneyFatCleaned_IsActive DEFAULT(1) FOR IsActive
END
GO
