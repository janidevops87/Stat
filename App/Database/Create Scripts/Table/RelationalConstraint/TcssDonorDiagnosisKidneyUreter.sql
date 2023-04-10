/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreter
**	Desc: Add Foreign keys to TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyUreter_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyUreter_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyUreter_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyUreter_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyUreter_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyUreter_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_TcssListKidney_TcssListKidneyId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_TcssListKidney_TcssListKidneyId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyId_TcssListKidney_TcssListKidneyId
			FOREIGN KEY(TcssListKidneyId) REFERENCES dbo.TcssListKidney(TcssListKidneyId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_TcssListKidneyUreter_TcssListKidneyUreterId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_TcssListKidneyUreter_TcssListKidneyUreterId'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterId_TcssListKidneyUreter_TcssListKidneyUreterId
			FOREIGN KEY(TcssListKidneyUreterId) REFERENCES dbo.TcssListKidneyUreter(TcssListKidneyUreterId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterTissueQualityId_TcssListKidneyUreterTissueQuality_TcssListKidneyUreterTiss')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterTissueQualityId_TcssListKidneyUreterTissueQuality_TcssListKidneyUreterTiss'
		ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT FK_TcssDonorDiagnosisKidneyUreter_TcssListKidneyUreterTissueQualityId_TcssListKidneyUreterTissueQuality_TcssListKidneyUreterTiss
			FOREIGN KEY(TcssListKidneyUreterTissueQualityId) REFERENCES dbo.TcssListKidneyUreterTissueQuality(TcssListKidneyUreterTissueQualityId) 
	END
GO
