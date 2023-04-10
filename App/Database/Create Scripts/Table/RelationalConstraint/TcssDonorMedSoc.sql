/***************************************************************************************************
**	Name: TcssDonorMedSoc
**	Desc: Add Foreign keys to TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHistoryOfDiabetesId_TcssListHistoryOfDiabetes_TcssListHistoryOfDiabetesId
			FOREIGN KEY(TcssListHistoryOfDiabetesId) REFERENCES dbo.TcssListHistoryOfDiabetes(TcssListHistoryOfDiabetesId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHistoryOfCancerId_TcssListHistoryOfCancer_TcssListHistoryOfCancerId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHistoryOfCancerId_TcssListHistoryOfCancer_TcssListHistoryOfCancerId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHistoryOfCancerId_TcssListHistoryOfCancer_TcssListHistoryOfCancerId
			FOREIGN KEY(TcssListHistoryOfCancerId) REFERENCES dbo.TcssListHistoryOfCancer(TcssListHistoryOfCancerId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHypertensionHistoryId_TcssListHypertensionHistory_TcssListHypertensionHistoryId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHypertensionHistoryId_TcssListHypertensionHistory_TcssListHypertensionHistoryId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHypertensionHistoryId_TcssListHypertensionHistory_TcssListHypertensionHistoryId
			FOREIGN KEY(TcssListHypertensionHistoryId) REFERENCES dbo.TcssListHypertensionHistory(TcssListHypertensionHistoryId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListCompliantWithTreatmentId_TcssListCompliantWithTreatment_TcssListCompliantWithTreatmentId
			FOREIGN KEY(TcssListCompliantWithTreatmentId) REFERENCES dbo.TcssListCompliantWithTreatment(TcssListCompliantWithTreatmentId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHistoryOfCoronaryArteryDiseaseId_TcssListHistoryOfCoronaryArteryDisease_TcssListHistoryOfCoronaryArte')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHistoryOfCoronaryArteryDiseaseId_TcssListHistoryOfCoronaryArteryDisease_TcssListHistoryOfCoronaryArte'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHistoryOfCoronaryArteryDiseaseId_TcssListHistoryOfCoronaryArteryDisease_TcssListHistoryOfCoronaryArte
			FOREIGN KEY(TcssListHistoryOfCoronaryArteryDiseaseId) REFERENCES dbo.TcssListHistoryOfCoronaryArteryDisease(TcssListHistoryOfCoronaryArteryDiseaseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_TcssListHistoryOfGastrointestinalDisease_TcssListHistoryOfGastroin')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_TcssListHistoryOfGastrointestinalDisease_TcssListHistoryOfGastroin'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHistoryOfGastrointestinalDiseaseId_TcssListHistoryOfGastrointestinalDisease_TcssListHistoryOfGastroin
			FOREIGN KEY(TcssListHistoryOfGastrointestinalDiseaseId) REFERENCES dbo.TcssListHistoryOfGastrointestinalDisease(TcssListHistoryOfGastrointestinalDiseaseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListChestTraumaId_TcssListChestTrauma_TcssListChestTraumaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListChestTraumaId_TcssListChestTrauma_TcssListChestTraumaId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListChestTraumaId_TcssListChestTrauma_TcssListChestTraumaId
			FOREIGN KEY(TcssListChestTraumaId) REFERENCES dbo.TcssListChestTrauma(TcssListChestTraumaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListCigaretteUseId_TcssListCigaretteUse_TcssListCigaretteUseId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListCigaretteUseId_TcssListCigaretteUse_TcssListCigaretteUseId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListCigaretteUseId_TcssListCigaretteUse_TcssListCigaretteUseId
			FOREIGN KEY(TcssListCigaretteUseId) REFERENCES dbo.TcssListCigaretteUse(TcssListCigaretteUseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListCigaretteUseContinuedId_TcssListCigaretteUseContinued_TcssListCigaretteUseContinuedId
			FOREIGN KEY(TcssListCigaretteUseContinuedId) REFERENCES dbo.TcssListCigaretteUseContinued(TcssListCigaretteUseContinuedId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListOtherDrugUseId_TcssListOtherDrugUse_TcssListOtherDrugUseId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListOtherDrugUseId_TcssListOtherDrugUse_TcssListOtherDrugUseId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListOtherDrugUseId_TcssListOtherDrugUse_TcssListOtherDrugUseId
			FOREIGN KEY(TcssListOtherDrugUseId) REFERENCES dbo.TcssListOtherDrugUse(TcssListOtherDrugUseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListHeavyAlcoholUseId_TcssListHeavyAlcoholUse_TcssListHeavyAlcoholUseId
			FOREIGN KEY(TcssListHeavyAlcoholUseId) REFERENCES dbo.TcssListHeavyAlcoholUse(TcssListHeavyAlcoholUseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId'
		ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT FK_TcssDonorMedSoc_TcssListDonorMeetCdcGuidelinesId_TcssListDonorMeetCdcGuidelines_TcssListDonorMeetCdcGuidelinesId
			FOREIGN KEY(TcssListDonorMeetCdcGuidelinesId) REFERENCES dbo.TcssListDonorMeetCdcGuidelines(TcssListDonorMeetCdcGuidelinesId) 
	END
GO
