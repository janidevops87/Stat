/***************************************************************************************************
**	Name: TcssDonorAbg
**	Desc: Add Foreign keys to TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorAbg_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorAbg_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorAbg ADD CONSTRAINT FK_TcssDonorAbg_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorAbg_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorAbg_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorAbg ADD CONSTRAINT FK_TcssDonorAbg_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorAbg_TcssListVentSettingModeId_TcssListVentSettingMode_TcssListVentSettingModeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorAbg_TcssListVentSettingModeId_TcssListVentSettingMode_TcssListVentSettingModeId'
		ALTER TABLE dbo.TcssDonorAbg ADD CONSTRAINT FK_TcssDonorAbg_TcssListVentSettingModeId_TcssListVentSettingMode_TcssListVentSettingModeId
			FOREIGN KEY(TcssListVentSettingModeId) REFERENCES dbo.TcssListVentSettingMode(TcssListVentSettingModeId) 
	END
GO
