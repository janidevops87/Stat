/***************************************************************************************************
**	Name: TcssDonorVitalSignDetail
**	Desc: Add Foreign keys to TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorVitalSignDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorVitalSignDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT FK_TcssDonorVitalSignDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorVitalSignDetail_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorVitalSignDetail_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT FK_TcssDonorVitalSignDetail_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

--IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorVitalSignDetail_TcssDonorVitalSignId_TcssDonorVitalSign_TcssDonorVitalSignId')
--	BEGIN
--		PRINT 'Adding Foreign Key FK_TcssDonorVitalSignDetail_TcssDonorVitalSignId_TcssDonorVitalSign_TcssDonorVitalSignId'
--		ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT FK_TcssDonorVitalSignDetail_TcssDonorVitalSignId_TcssDonorVitalSign_TcssDonorVitalSignId
--			FOREIGN KEY(TcssDonorVitalSignId) REFERENCES dbo.TcssDonorVitalSign(TcssDonorVitalSignId) 
--	END
--GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorVitalSignDetail_TcssListVitalSignId_TcssListVitalSign_TcssListVitalSignId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorVitalSignDetail_TcssListVitalSignId_TcssListVitalSign_TcssListVitalSignId'
		ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT FK_TcssDonorVitalSignDetail_TcssListVitalSignId_TcssListVitalSign_TcssListVitalSignId
			FOREIGN KEY(TcssListVitalSignId) REFERENCES dbo.TcssListVitalSign(TcssListVitalSignId) 
	END
GO
