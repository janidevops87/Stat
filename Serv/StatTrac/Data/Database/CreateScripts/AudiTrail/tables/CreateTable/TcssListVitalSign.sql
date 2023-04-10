/***************************************************************************************************
**	Name: TcssListVitalSign
**	Desc: Creates new table TcssListVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Table Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssListVitalSign')
BEGIN
	-- DROP TABLE dbo.TcssListVitalSign
	PRINT 'Creating table TcssListVitalSign'
	CREATE TABLE dbo.TcssListVitalSign
	(
		TcssListVitalSignId int NOT NULL ,
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
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsLung')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsLung'
	ALTER TABLE dbo.TcssListVitalSign ADD IsLung int NULL
END
GO

-- Adds a new column IsHeart that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsHeart')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsHeart'
	ALTER TABLE dbo.TcssListVitalSign ADD IsHeart int NULL
END
GO

-- Adds a new column IsIntestine that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsIntestine')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsIntestine'
	ALTER TABLE dbo.TcssListVitalSign ADD IsIntestine int NULL
END
GO

-- Adds a new column IsPancreas that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsPancreas')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsPancreas'
	ALTER TABLE dbo.TcssListVitalSign ADD IsPancreas int NULL
END
GO

-- Adds a new column IsHeartLung that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsHeartLung')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsHeartLung'
	ALTER TABLE dbo.TcssListVitalSign ADD IsHeartLung int NULL
END
GO

-- Adds a new column IsKidneyPancreas that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsKidneyPancreas')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsKidneyPancreas'
	ALTER TABLE dbo.TcssListVitalSign ADD IsKidneyPancreas int NULL
END
GO

-- Adds a new column IsMultiOrgan that specifies if this needs to be displayed in the summary
IF NOT EXISTS(select name from syscolumns where id = (select id from sysobjects where name = 'TcssListVitalSign') AND name = 'IsMultiOrgan')
BEGIN
	PRINT 'ALTER TABLE dbo.TcssListVitalSign Add Column IsMultiOrgan'
	ALTER TABLE dbo.TcssListVitalSign ADD IsMultiOrgan int NULL
END
GO

GRANT SELECT ON TcssListVitalSign TO PUBLIC
GO
