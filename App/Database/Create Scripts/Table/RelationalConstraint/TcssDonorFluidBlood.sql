/***************************************************************************************************
**	Name: TcssDonorFluidBlood
**	Desc: Add Foreign keys to TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListDextroseInIvFluidsId_TcssListDextroseInIvFluids_TcssListDextroseInIvFluidsId
			FOREIGN KEY(TcssListDextroseInIvFluidsId) REFERENCES dbo.TcssListDextroseInIvFluids(TcssListDextroseInIvFluidsId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListSteroidId_TcssListSteroid_TcssListSteroidId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListSteroidId_TcssListSteroid_TcssListSteroidId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListSteroidId_TcssListSteroid_TcssListSteroidId
			FOREIGN KEY(TcssListSteroidId) REFERENCES dbo.TcssListSteroid(TcssListSteroidId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListDiureticId_TcssListDiuretic_TcssListDiureticId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListDiureticId_TcssListDiuretic_TcssListDiureticId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListDiureticId_TcssListDiuretic_TcssListDiureticId
			FOREIGN KEY(TcssListDiureticId) REFERENCES dbo.TcssListDiuretic(TcssListDiureticId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListT3Id_TcssListT3_TcssListT3Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListT3Id_TcssListT3_TcssListT3Id'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListT3Id_TcssListT3_TcssListT3Id
			FOREIGN KEY(TcssListT3Id) REFERENCES dbo.TcssListT3(TcssListT3Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListT4Id_TcssListT4_TcssListT4Id')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListT4Id_TcssListT4_TcssListT4Id'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListT4Id_TcssListT4_TcssListT4Id
			FOREIGN KEY(TcssListT4Id) REFERENCES dbo.TcssListT4(TcssListT4Id) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListInsulinId_TcssListInsulin_TcssListInsulinId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListInsulinId_TcssListInsulin_TcssListInsulinId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListInsulinId_TcssListInsulin_TcssListInsulinId
			FOREIGN KEY(TcssListInsulinId) REFERENCES dbo.TcssListInsulin(TcssListInsulinId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListAntihypertensiveId_TcssListAntihypertensive_TcssListAntihypertensiveId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListAntihypertensiveId_TcssListAntihypertensive_TcssListAntihypertensiveId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListAntihypertensiveId_TcssListAntihypertensive_TcssListAntihypertensiveId
			FOREIGN KEY(TcssListAntihypertensiveId) REFERENCES dbo.TcssListAntihypertensive(TcssListAntihypertensiveId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListVasodilatorId_TcssListVasodilator_TcssListVasodilatorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListVasodilatorId_TcssListVasodilator_TcssListVasodilatorId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListVasodilatorId_TcssListVasodilator_TcssListVasodilatorId
			FOREIGN KEY(TcssListVasodilatorId) REFERENCES dbo.TcssListVasodilator(TcssListVasodilatorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListDdavpId_TcssListDdavp_TcssListDdavpId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListDdavpId_TcssListDdavp_TcssListDdavpId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListDdavpId_TcssListDdavp_TcssListDdavpId
			FOREIGN KEY(TcssListDdavpId) REFERENCES dbo.TcssListDdavp(TcssListDdavpId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListArginineVasopressinId_TcssListArginineVasopressin_TcssListArginineVasopressinId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListArginineVasopressinId_TcssListArginineVasopressin_TcssListArginineVasopressinId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListArginineVasopressinId_TcssListArginineVasopressin_TcssListArginineVasopressinId
			FOREIGN KEY(TcssListArginineVasopressinId) REFERENCES dbo.TcssListArginineVasopressin(TcssListArginineVasopressinId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListNumberOfTransfusionId_TcssListNumberOfTransfusion_TcssListNumberOfTransfusionId
			FOREIGN KEY(TcssListNumberOfTransfusionId) REFERENCES dbo.TcssListNumberOfTransfusion(TcssListNumberOfTransfusionId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorFluidBlood_TcssListOtherBloodProductId_TcssListOtherBloodProduct_TcssListOtherBloodProductId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorFluidBlood_TcssListOtherBloodProductId_TcssListOtherBloodProduct_TcssListOtherBloodProductId'
		ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT FK_TcssDonorFluidBlood_TcssListOtherBloodProductId_TcssListOtherBloodProduct_TcssListOtherBloodProductId
			FOREIGN KEY(TcssListOtherBloodProductId) REFERENCES dbo.TcssListOtherBloodProduct(TcssListOtherBloodProductId) 
	END
GO
