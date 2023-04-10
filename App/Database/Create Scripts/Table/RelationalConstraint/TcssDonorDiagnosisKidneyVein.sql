/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVein
**	Desc: Add Foreign keys to TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyVein_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyVein_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyVein_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyVein_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyVein_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyVein_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_TcssListKidney_TcssListKidneyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_TcssListKidney_TcssListKidneyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyId_TcssListKidney_TcssListKidneyId
			FOREIGN KEY(TcssListKidneyId) REFERENCES dbo.TcssListKidney(TcssListKidneyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_TcssListKidneyVein_TcssListKidneyVeinId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_TcssListKidneyVein_TcssListKidneyVeinId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyVein_TcssListKidneyVeinId_TcssListKidneyVein_TcssListKidneyVeinId
			FOREIGN KEY(TcssListKidneyVeinId) REFERENCES dbo.TcssListKidneyVein(TcssListKidneyVeinId) 
	END
GO
