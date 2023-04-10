/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiver
**	Desc: Add Foreign keys to TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisLiver ADD CONSTRAINT FK_TcssDonorDiagnosisLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLiver_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLiver_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisLiver ADD CONSTRAINT FK_TcssDonorDiagnosisLiver_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLiver_TcssListLiverBiopsyId_TcssListLiverBiopsy_TcssListLiverBiopsyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLiver_TcssListLiverBiopsyId_TcssListLiverBiopsy_TcssListLiverBiopsyId'
		ALTER TABLE dbo.TcssDonorDiagnosisLiver ADD CONSTRAINT FK_TcssDonorDiagnosisLiver_TcssListLiverBiopsyId_TcssListLiverBiopsy_TcssListLiverBiopsyId
			FOREIGN KEY(TcssListLiverBiopsyId) REFERENCES dbo.TcssListLiverBiopsy(TcssListLiverBiopsyId) 
	END
GO
