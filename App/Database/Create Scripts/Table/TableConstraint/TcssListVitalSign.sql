/***************************************************************************************************
**	Name: TcssListVitalSign
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	05/29/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListVitalSign')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListVitalSign'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT PK_TcssListVitalSign PRIMARY KEY Clustered (TcssListVitalSignId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_LastUpdateDate'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_SortOrder'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsActive'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsActive DEFAULT(1) FOR IsActive
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_ConfigVersion')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_ConfigVersion'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_ConfigVersion DEFAULT(0) FOR ConfigVersion
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsLiver')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsLiver'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsLiver DEFAULT(0) FOR IsLiver
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsKidney')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsKidney'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsKidney DEFAULT(0) FOR IsKidney
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsLung')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsLung'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsLung DEFAULT(0) FOR IsLung
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsLung = 0 WHERE IsLung IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsLung bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsHeart')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsHeart'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsHeart DEFAULT(0) FOR IsHeart
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsHeart = 0 WHERE IsHeart IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsHeart bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsIntestine')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsIntestine'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsIntestine DEFAULT(0) FOR IsIntestine
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsIntestine = 0 WHERE IsIntestine IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsIntestine bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsPancreas')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsPancreas'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsPancreas DEFAULT(0) FOR IsPancreas
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsPancreas = 0 WHERE IsPancreas IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsPancreas bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsHeartLung')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsHeartLung'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsHeartLung DEFAULT(0) FOR IsHeartLung
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsHeartLung = 0 WHERE IsHeartLung IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsHeartLung bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsKidneyPancreas')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsKidneyPancreas'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsKidneyPancreas DEFAULT(0) FOR IsKidneyPancreas
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsKidneyPancreas = 0 WHERE IsKidneyPancreas IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsKidneyPancreas bit NOT NULL
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListVitalSign_IsMultiOrgan')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListVitalSign_IsMultiOrgan'
	ALTER TABLE dbo.TcssListVitalSign ADD CONSTRAINT DF_TcssListVitalSign_IsMultiOrgan DEFAULT(0) FOR IsMultiOrgan
	-- Set all existing values to 0 where it is currently nulll
	UPDATE TcssListVitalSign SET IsMultiOrgan = 0 WHERE IsMultiOrgan IS NULL
	-- Alter the column to prevent null data
	ALTER TABLE TcssListVitalSign ALTER COLUMN IsMultiOrgan bit NOT NULL
END
GO



