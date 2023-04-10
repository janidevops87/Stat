/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeart
**	Desc: Add Foreign keys to TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisHeart_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisHeart_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisHeart ADD CONSTRAINT FK_TcssDonorDiagnosisHeart_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisHeart_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisHeart_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisHeart ADD CONSTRAINT FK_TcssDonorDiagnosisHeart_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId'
		ALTER TABLE dbo.TcssDonorDiagnosisHeart ADD CONSTRAINT FK_TcssDonorDiagnosisHeart_TcssListDiagnosisHeartMethodId_TcssListDiagnosisHeartMethod_TcssListDiagnosisHeartMethodId
			FOREIGN KEY(TcssListDiagnosisHeartMethodId) REFERENCES dbo.TcssListDiagnosisHeartMethod(TcssListDiagnosisHeartMethodId) 
	END
GO
