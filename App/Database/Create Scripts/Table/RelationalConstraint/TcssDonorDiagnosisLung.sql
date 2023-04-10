/***************************************************************************************************
**	Name: TcssDonorDiagnosisLung
**	Desc: Add Foreign keys to TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLung_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLung_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorDiagnosisLung ADD CONSTRAINT FK_TcssDonorDiagnosisLung_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLung_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLung_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorDiagnosisLung ADD CONSTRAINT FK_TcssDonorDiagnosisLung_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorDiagnosisLung_TcssListDiagnosisLungChestXrayId_TcssListDiagnosisLungChestXray_TcssListDiagnosisLungChestXrayId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorDiagnosisLung_TcssListDiagnosisLungChestXrayId_TcssListDiagnosisLungChestXray_TcssListDiagnosisLungChestXrayId'
		ALTER TABLE dbo.TcssDonorDiagnosisLung ADD CONSTRAINT FK_TcssDonorDiagnosisLung_TcssListDiagnosisLungChestXrayId_TcssListDiagnosisLungChestXray_TcssListDiagnosisLungChestXrayId
			FOREIGN KEY(TcssListDiagnosisLungChestXrayId) REFERENCES dbo.TcssListDiagnosisLungChestXray(TcssListDiagnosisLungChestXrayId) 
	END
GO
