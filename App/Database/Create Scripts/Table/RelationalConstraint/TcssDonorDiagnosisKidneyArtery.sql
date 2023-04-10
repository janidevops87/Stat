/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArtery
**	Desc: Add Foreign keys to TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyArtery_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyArtery_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyArtery_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyArtery_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyArtery_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyArtery_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_TcssListKidney_TcssListKidneyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_TcssListKidney_TcssListKidneyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyId_TcssListKidney_TcssListKidneyId
			FOREIGN KEY(TcssListKidneyId) REFERENCES dbo.TcssListKidney(TcssListKidneyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_TcssListKidneyArtery_TcssListKidneyArteryId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_TcssListKidneyArtery_TcssListKidneyArteryId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyArtery_TcssListKidneyArteryId_TcssListKidneyArtery_TcssListKidneyArteryId
			FOREIGN KEY(TcssListKidneyArteryId) REFERENCES dbo.TcssListKidneyArtery(TcssListKidneyArteryId) 
	END
GO
