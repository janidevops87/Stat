/***************************************************************************************************
**	Name: TcssDonorFluidBlood
**	Desc: Creates new table TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Table Creation 
**  11/10		jth				add 4 Heparin fields requirment 8249
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE xtype='U' AND name = 'TcssDonorFluidBlood')
BEGIN
	-- DROP TABLE dbo.TcssDonorFluidBlood
	PRINT 'Creating table TcssDonorFluidBlood'
	CREATE TABLE dbo.TcssDonorFluidBlood
	(
		TcssDonorFluidBloodId int NOT NULL ,
		LastUpdateStatEmployeeId int NULL,
		LastUpdateDate datetime NULL,
		TcssDonorId int NULL,
		IvFluids varchar(50) NULL,
		TcssListDextroseInIvFluidsId int NULL,
		TcssListSteroidId int NULL,
		SteroidsDetail varchar(50) NULL,
		TcssListDiureticId int NULL,
		TcssListT3Id int NULL,
		TcssListT4Id int NULL,
		TcssListInsulinId int NULL,
		InsulinBeginDateTime smalldatetime NULL,
		InsulinEndDateTime smalldatetime NULL,
		TcssListAntihypertensiveId int NULL,
		TcssListVasodilatorId int NULL,
		TcssListDdavpId int NULL,
		TcssListArginineVasopressinId int NULL,
		ArginlineBeginDateTime smalldatetime NULL,
		ArginlineEndDateTime smalldatetime NULL,
		TotalParenteralNutrition int NULL,
		OtherSpecify1 varchar(40) NULL,
		OtherSpecify2 varchar(40) NULL,
		OtherSpecify3 varchar(40) NULL,
		TcssListNumberOfTransfusionId int NULL,
		TcssListOtherBloodProductId int NULL,
		OtherBloodProductsDetails varchar(500) NULL
	)
END
GO

-- Add a new column DiureticDetail
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'DiureticDetail')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood ADD DiureticDetail varchar(50) NULL
	ALTER TABLE dbo.TcssDonorFluidBlood ALTER COLUMN TotalParenteralNutrition varchar(50) NULL
END
GO

-- Add a new column HeparinBeginDate
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'HeparinBeginDate')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood ADD HeparinBeginDate smalldatetime NULL
END
GO

-- Add a new column HeparinEndDate
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'HeparinEndDate')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood ADD HeparinEndDate smalldatetime NULL
END
GO

-- Add a new column HeparinDosage
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'HeparinDosage')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood ADD HeparinDosage varchar(50) NULL
END
GO

-- Add a new column HeparinListID
IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'TcssListHeparinId')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood ADD TcssListHeparinId int NULL
END
GO

IF NOT EXISTS (SELECT * FROM syscolumns WHERE id = (SELECT id FROM sysobjects WHERE name = 'TcssDonorFluidBlood') AND name = 'TcssListTotalParenteralNutritionId')
BEGIN
	ALTER TABLE dbo.TcssDonorFluidBlood Add TcssListTotalParenteralNutritionId int null
END
GO
GRANT SELECT ON TcssDonorFluidBlood TO PUBLIC
GO
