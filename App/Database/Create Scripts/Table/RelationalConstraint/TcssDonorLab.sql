/***************************************************************************************************
**	Name: TcssDonorLab
**	Desc: Add Foreign keys to TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLab_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLab_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorLab ADD CONSTRAINT FK_TcssDonorLab_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLab_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLab_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorLab ADD CONSTRAINT FK_TcssDonorLab_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLab_TcssListToxicologyScreenId_TcssListToxicologyScreen_TcssListToxicologyScreenId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLab_TcssListToxicologyScreenId_TcssListToxicologyScreen_TcssListToxicologyScreenId'
		ALTER TABLE dbo.TcssDonorLab ADD CONSTRAINT FK_TcssDonorLab_TcssListToxicologyScreenId_TcssListToxicologyScreen_TcssListToxicologyScreenId
			FOREIGN KEY(TcssListToxicologyScreenId) REFERENCES dbo.TcssListToxicologyScreen(TcssListToxicologyScreenId) 
	END
GO
