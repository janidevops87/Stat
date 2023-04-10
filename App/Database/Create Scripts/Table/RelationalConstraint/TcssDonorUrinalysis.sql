/***************************************************************************************************
**	Name: TcssDonorUrinalysis
**	Desc: Add Foreign keys to TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisProteinId_TcssListUrinalysisProtein_TcssListUrinalysisProteinId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisProteinId_TcssListUrinalysisProtein_TcssListUrinalysisProteinId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisProteinId_TcssListUrinalysisProtein_TcssListUrinalysisProteinId
			FOREIGN KEY(TcssListUrinalysisProteinId) REFERENCES dbo.TcssListUrinalysisProtein(TcssListUrinalysisProteinId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisGlucoseId_TcssListUrinalysisGlucose_TcssListUrinalysisGlucoseId
			FOREIGN KEY(TcssListUrinalysisGlucoseId) REFERENCES dbo.TcssListUrinalysisGlucose(TcssListUrinalysisGlucoseId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisBloodId_TcssListUrinalysisBlood_TcssListUrinalysisBloodId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisBloodId_TcssListUrinalysisBlood_TcssListUrinalysisBloodId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisBloodId_TcssListUrinalysisBlood_TcssListUrinalysisBloodId
			FOREIGN KEY(TcssListUrinalysisBloodId) REFERENCES dbo.TcssListUrinalysisBlood(TcssListUrinalysisBloodId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisRbcId_TcssListUrinalysisRbc_TcssListUrinalysisRbcId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisRbcId_TcssListUrinalysisRbc_TcssListUrinalysisRbcId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisRbcId_TcssListUrinalysisRbc_TcssListUrinalysisRbcId
			FOREIGN KEY(TcssListUrinalysisRbcId) REFERENCES dbo.TcssListUrinalysisRbc(TcssListUrinalysisRbcId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisWbcId_TcssListUrinalysisWbc_TcssListUrinalysisWbcId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisWbcId_TcssListUrinalysisWbc_TcssListUrinalysisWbcId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisWbcId_TcssListUrinalysisWbc_TcssListUrinalysisWbcId
			FOREIGN KEY(TcssListUrinalysisWbcId) REFERENCES dbo.TcssListUrinalysisWbc(TcssListUrinalysisWbcId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisEpithId_TcssListUrinalysisEpith_TcssListUrinalysisEpithId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisEpithId_TcssListUrinalysisEpith_TcssListUrinalysisEpithId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisEpithId_TcssListUrinalysisEpith_TcssListUrinalysisEpithId
			FOREIGN KEY(TcssListUrinalysisEpithId) REFERENCES dbo.TcssListUrinalysisEpith(TcssListUrinalysisEpithId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisCastId_TcssListUrinalysisCast_TcssListUrinalysisCastId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisCastId_TcssListUrinalysisCast_TcssListUrinalysisCastId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisCastId_TcssListUrinalysisCast_TcssListUrinalysisCastId
			FOREIGN KEY(TcssListUrinalysisCastId) REFERENCES dbo.TcssListUrinalysisCast(TcssListUrinalysisCastId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisBacteriaId_TcssListUrinalysisBacteria_TcssListUrinalysisBacteriaId
			FOREIGN KEY(TcssListUrinalysisBacteriaId) REFERENCES dbo.TcssListUrinalysisBacteria(TcssListUrinalysisBacteriaId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId'
		ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT FK_TcssDonorUrinalysis_TcssListUrinalysisLeukocyteId_TcssListUrinalysisLeukocyte_TcssListUrinalysisLeukocyteId
			FOREIGN KEY(TcssListUrinalysisLeukocyteId) REFERENCES dbo.TcssListUrinalysisLeukocyte(TcssListUrinalysisLeukocyteId) 
	END
GO
