/***************************************************************************************************
**	Name: TcssListLab
**	Desc: Creates new table TcssListLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListLab')
BEGIN
	-- DROP TABLE dbo.TcssListLab
	PRINT 'Creating table TcssListLab'
	CREATE TABLE dbo.TcssListLab
	(
		TcssListLabId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		SortOrder int NULL,
		IsActive int NULL,
		FieldValue varchar(100) NULL,
		UnosValue varchar(100) NULL,
		ConfigVersion bigint NULL,
		IsLiver int NULL,
		IsKidney int NULL
	)
END
GO

-- Adds a new column IsLung that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsLung')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsLung'
	ALTER TABLE dbo.TcssListLab ADD IsLung int
END
GO

-- Adds a new column IsHeart that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsHeart')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsHeart'
	ALTER TABLE dbo.TcssListLab ADD IsHeart int
END
GO

-- Adds a new column IsIntestine that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsIntestine')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsIntestine'
	ALTER TABLE dbo.TcssListLab ADD IsIntestine int
END
GO

-- Adds a new column IsPancreas that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsPancreas')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsPancreas'
	ALTER TABLE dbo.TcssListLab ADD IsPancreas int
END
GO

-- Adds a new column IsHeartLung that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsHeartLung')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsHeartLung'
	ALTER TABLE dbo.TcssListLab ADD IsHeartLung int
END
GO

-- Adds a new column IsKidneyPancreas that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsKidneyPancreas')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsKidneyPancreas'
	ALTER TABLE dbo.TcssListLab ADD IsKidneyPancreas int
END
GO

-- Adds a new column IsMultiOrgan that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListLab') AND name = 'IsMultiOrgan')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListLab Add Column IsMultiOrgan'
	ALTER TABLE dbo.TcssListLab ADD IsMultiOrgan int
END
GO

GRANT SELECT ON TcssListLab TO PUBLIC
GO
