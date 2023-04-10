/***************************************************************************************************
**	Name: TcssDonorMedication
**	Desc: Add Foreign keys to TcssDonorMedication
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedication_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedication_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT FK_TcssDonorMedication_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedication_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedication_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT FK_TcssDonorMedication_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedication_TcssListMedicationId_TcssListMedication_TcssListMedicationId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedication_TcssListMedicationId_TcssListMedication_TcssListMedicationId'
		ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT FK_TcssDonorMedication_TcssListMedicationId_TcssListMedication_TcssListMedicationId
			FOREIGN KEY(TcssListMedicationId) REFERENCES dbo.TcssListMedication(TcssListMedicationId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorMedication_TcssListMedicationDoseUnitId_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorMedication_TcssListMedicationDoseUnitId_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId'
		ALTER TABLE dbo.TcssDonorMedication ADD CONSTRAINT FK_TcssDonorMedication_TcssListMedicationDoseUnitId_TcssListMedicationDoseUnit_TcssListMedicationDoseUnitId
			FOREIGN KEY(TcssListMedicationDoseUnitId) REFERENCES dbo.TcssListMedicationDoseUnit(TcssListMedicationDoseUnitId) 
	END
GO
