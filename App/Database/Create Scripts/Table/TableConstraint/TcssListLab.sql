/***************************************************************************************************
**	Name: TcssListLab
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	05/29/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListLab')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListLab'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT PK_TcssListLab PRIMARY KEY Clustered (TcssListLabId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_LastUpdateDate'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_SortOrder'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsActive'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsActive DEFAULT(1) FOR IsActive
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_ConfigVersion')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_ConfigVersion'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_ConfigVersion DEFAULT(0) FOR ConfigVersion
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsLiver')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsLiver'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsLiver DEFAULT(0) FOR IsLiver
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsKidney')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsKidney'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsKidney DEFAULT(0) FOR IsKidney
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsLung')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsLung'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsLung DEFAULT(0) FOR IsLung
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsLung = 0 WHERE IsLung IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsLung bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsHeart')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsHeart'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsHeart DEFAULT(0) FOR IsHeart
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsHeart = 0 WHERE IsHeart IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsHeart bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsIntestine')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsIntestine'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsIntestine DEFAULT(0) FOR IsIntestine
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsIntestine = 0 WHERE IsIntestine IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsIntestine bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsPancreas')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsPancreas'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsPancreas DEFAULT(0) FOR IsPancreas
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsPancreas = 0 WHERE IsPancreas IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsPancreas bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsHeartLung')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsHeartLung'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsHeartLung DEFAULT(0) FOR IsHeartLung
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsHeartLung = 0 WHERE IsHeartLung IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsHeartLung bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsKidneyPancreas')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsKidneyPancreas'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsKidneyPancreas DEFAULT(0) FOR IsKidneyPancreas
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsKidneyPancreas = 0 WHERE IsKidneyPancreas IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsKidneyPancreas bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListLab_IsMultiOrgan')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListLab_IsMultiOrgan'
	ALTER TABLE dbo.TcssListLab ADD CONSTRAINT DF_TcssListLab_IsMultiOrgan DEFAULT(0) FOR IsMultiOrgan
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListLab SET IsMultiOrgan = 0 WHERE IsMultiOrgan IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListLab ALTER COLUMN IsMultiOrgan bit NOT NULL
END
GO
