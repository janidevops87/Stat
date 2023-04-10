/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidney
**	Desc: Add Foreign keys to TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyId_TcssListKidney_TcssListKidneyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyId_TcssListKidney_TcssListKidneyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyId_TcssListKidney_TcssListKidneyId
			FOREIGN KEY(TcssListKidneyId) REFERENCES dbo.TcssListKidney(TcssListKidneyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticCuffId_TcssListKidneyAorticCuff_TcssListKidneyAorticCuffId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticCuffId_TcssListKidneyAorticCuff_TcssListKidneyAorticCuffId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticCuffId_TcssListKidneyAorticCuff_TcssListKidneyAorticCuffId
			FOREIGN KEY(TcssListKidneyAorticCuffId) REFERENCES dbo.TcssListKidneyAorticCuff(TcssListKidneyAorticCuffId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyFullVenaId_TcssListKidneyFullVena_TcssListKidneyFullVenaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyFullVenaId_TcssListKidneyFullVena_TcssListKidneyFullVenaId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyFullVenaId_TcssListKidneyFullVena_TcssListKidneyFullVenaId
			FOREIGN KEY(TcssListKidneyFullVenaId) REFERENCES dbo.TcssListKidneyFullVena(TcssListKidneyFullVenaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticPlaqueId_TcssListKidneyAorticPlaque_TcssListKidneyAorticPlaqueId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticPlaqueId_TcssListKidneyAorticPlaque_TcssListKidneyAorticPlaqueId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyAorticPlaqueId_TcssListKidneyAorticPlaque_TcssListKidneyAorticPlaqueId
			FOREIGN KEY(TcssListKidneyAorticPlaqueId) REFERENCES dbo.TcssListKidneyAorticPlaque(TcssListKidneyAorticPlaqueId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyArterialPlaqueId_TcssListKidneyArterialPlaque_TcssListKidneyArterialPlaqueId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyArterialPlaqueId_TcssListKidneyArterialPlaque_TcssListKidneyArterialPlaqueId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyArterialPlaqueId_TcssListKidneyArterialPlaque_TcssListKidneyArterialPlaqueId
			FOREIGN KEY(TcssListKidneyArterialPlaqueId) REFERENCES dbo.TcssListKidneyArterialPlaque(TcssListKidneyArterialPlaqueId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyInfarctedAreaId_TcssListKidneyInfarctedArea_TcssListKidneyInfarctedAreaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyInfarctedAreaId_TcssListKidneyInfarctedArea_TcssListKidneyInfarctedAreaId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyInfarctedAreaId_TcssListKidneyInfarctedArea_TcssListKidneyInfarctedAreaId
			FOREIGN KEY(TcssListKidneyInfarctedAreaId) REFERENCES dbo.TcssListKidneyInfarctedArea(TcssListKidneyInfarctedAreaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyCapsularTearId_TcssListKidneyCapsularTear_TcssListKidneyCapsularTearId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyCapsularTearId_TcssListKidneyCapsularTear_TcssListKidneyCapsularTearId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyCapsularTearId_TcssListKidneyCapsularTear_TcssListKidneyCapsularTearId
			FOREIGN KEY(TcssListKidneyCapsularTearId) REFERENCES dbo.TcssListKidneyCapsularTear(TcssListKidneyCapsularTearId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneySubcapsularId_TcssListKidneySubcapsular_TcssListKidneySubcapsularId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneySubcapsularId_TcssListKidneySubcapsular_TcssListKidneySubcapsularId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneySubcapsularId_TcssListKidneySubcapsular_TcssListKidneySubcapsularId
			FOREIGN KEY(TcssListKidneySubcapsularId) REFERENCES dbo.TcssListKidneySubcapsular(TcssListKidneySubcapsularId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyHematomaId_TcssListKidneyHematoma_TcssListKidneyHematomaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyHematomaId_TcssListKidneyHematoma_TcssListKidneyHematomaId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyHematomaId_TcssListKidneyHematoma_TcssListKidneyHematomaId
			FOREIGN KEY(TcssListKidneyHematomaId) REFERENCES dbo.TcssListKidneyHematoma(TcssListKidneyHematomaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyFatCleanedId_TcssListKidneyFatCleaned_TcssListKidneyFatCleanedId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyFatCleanedId_TcssListKidneyFatCleaned_TcssListKidneyFatCleanedId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyFatCleanedId_TcssListKidneyFatCleaned_TcssListKidneyFatCleanedId
			FOREIGN KEY(TcssListKidneyFatCleanedId) REFERENCES dbo.TcssListKidneyFatCleaned(TcssListKidneyFatCleanedId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyCystsDiscolorationId_TcssListKidneyCystsDiscoloration_TcssListKidneyCystsDiscoloration')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyCystsDiscolorationId_TcssListKidneyCystsDiscoloration_TcssListKidneyCystsDiscoloration'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyCystsDiscolorationId_TcssListKidneyCystsDiscoloration_TcssListKidneyCystsDiscoloration
			FOREIGN KEY(TcssListKidneyCystsDiscolorationId) REFERENCES dbo.TcssListKidneyCystsDiscoloration(TcssListKidneyCystsDiscolorationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyHorseshoeShapeId_TcssListKidneyHorseshoeShape_TcssListKidneyHorseshoeShapeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyHorseshoeShapeId_TcssListKidneyHorseshoeShape_TcssListKidneyHorseshoeShapeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyHorseshoeShapeId_TcssListKidneyHorseshoeShape_TcssListKidneyHorseshoeShapeId
			FOREIGN KEY(TcssListKidneyHorseshoeShapeId) REFERENCES dbo.TcssListKidneyHorseshoeShape(TcssListKidneyHorseshoeShapeId) 
	END
GO

IF EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyRecoveryBiopsyId_TcssListKidneyRecoveryBiopsy_TcssListKidneyRecoveryBiopsyId')
	BEGIN
		PRINT 'Dropping Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyRecoveryBiopsyId_TcssListKidneyRecoveryBiopsy_TcssListKidneyRecoveryBiopsyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney DROP CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyRecoveryBiopsyId_TcssListKidneyRecoveryBiopsy_TcssListKidneyRecoveryBiopsyId
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_TcssListKidneyBiopsy_TcssListKidneyBiopsyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_TcssListKidneyBiopsy_TcssListKidneyBiopsyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyBiopsyId_TcssListKidneyBiopsy_TcssListKidneyBiopsyId
			FOREIGN KEY(TcssListKidneyBiopsyId) REFERENCES dbo.TcssListKidneyBiopsy(TcssListKidneyBiopsyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpDeviceId_TcssListKidneyPumpDevice_TcssListKidneyPumpDeviceId
			FOREIGN KEY(TcssListKidneyPumpDeviceId) REFERENCES dbo.TcssListKidneyPumpDevice(TcssListKidneyPumpDeviceId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT FK_TcssDonorDiagnosisKidney_TcssListKidneyPumpSolutionId_TcssListKidneyPumpSolution_TcssListKidneyPumpSolutionId
			FOREIGN KEY(TcssListKidneyPumpSolutionId) REFERENCES dbo.TcssListKidneyPumpSolution(TcssListKidneyPumpSolutionId) 
	END
GO
