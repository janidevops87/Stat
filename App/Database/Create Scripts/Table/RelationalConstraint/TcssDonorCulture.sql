/***************************************************************************************************
**	Name: TcssDonorCulture
**	Desc: Add Foreign keys to TcssDonorCulture
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorCulture_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorCulture_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorCulture ADD CONSTRAINT FK_TcssDonorCulture_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorCulture_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorCulture_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorCulture ADD CONSTRAINT FK_TcssDonorCulture_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorCulture_TcssListCultureTypeId_TcssListCultureType_TcssListCultureTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorCulture_TcssListCultureTypeId_TcssListCultureType_TcssListCultureTypeId'
		ALTER TABLE dbo.TcssDonorCulture ADD CONSTRAINT FK_TcssDonorCulture_TcssListCultureTypeId_TcssListCultureType_TcssListCultureTypeId
			FOREIGN KEY(TcssListCultureTypeId) REFERENCES dbo.TcssListCultureType(TcssListCultureTypeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorCulture_TcssListCultureResultId_TcssListCultureResult_TcssListCultureResultId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorCulture_TcssListCultureResultId_TcssListCultureResult_TcssListCultureResultId'
		ALTER TABLE dbo.TcssDonorCulture ADD CONSTRAINT FK_TcssDonorCulture_TcssListCultureResultId_TcssListCultureResult_TcssListCultureResultId
			FOREIGN KEY(TcssListCultureResultId) REFERENCES dbo.TcssListCultureResult(TcssListCultureResultId) 
	END
GO
