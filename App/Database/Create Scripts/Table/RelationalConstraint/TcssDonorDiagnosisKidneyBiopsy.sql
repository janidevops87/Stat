/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsy
**	Desc: Add Foreign keys to TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyBiopsy_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyBiopsy_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyBiopsy ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyBiopsy_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyBiopsy ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyBiopsy_TcssListKidneyId_TcssListKidney_TcssListKidneyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyBiopsy_TcssListKidneyId_TcssListKidney_TcssListKidneyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyBiopsy ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyBiopsy_TcssListKidneyId_TcssListKidney_TcssListKidneyId
			FOREIGN KEY(TcssListKidneyId) REFERENCES dbo.TcssListKidney(TcssListKidneyId) 
	END
GO
