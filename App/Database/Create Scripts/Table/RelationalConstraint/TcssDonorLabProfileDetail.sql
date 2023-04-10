/***************************************************************************************************
**	Name: TcssDonorLabProfileDetail
**	Desc: Add Foreign keys to TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLabProfileDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLabProfileDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT FK_TcssDonorLabProfileDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLabProfileDetail_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLabProfileDetail_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT FK_TcssDonorLabProfileDetail_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

--IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLabProfileDetail_TcssDonorLabProfileId_TcssDonorLabProfile_TcssDonorLabProfileId')
--	BEGIN
--		PRINT 'Adding Foreign Key FK_TcssDonorLabProfileDetail_TcssDonorLabProfileId_TcssDonorLabProfile_TcssDonorLabProfileId'
--		ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT FK_TcssDonorLabProfileDetail_TcssDonorLabProfileId_TcssDonorLabProfile_TcssDonorLabProfileId
--			FOREIGN KEY(TcssDonorLabProfileId) REFERENCES dbo.TcssDonorLabProfile(TcssDonorLabProfileId) 
--	END
--GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorLabProfileDetail_TcssListLabId_TcssListLab_TcssListLabId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorLabProfileDetail_TcssListLabId_TcssListLab_TcssListLabId'
		ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT FK_TcssDonorLabProfileDetail_TcssListLabId_TcssListLab_TcssListLabId
			FOREIGN KEY(TcssListLabId) REFERENCES dbo.TcssListLab(TcssListLabId) 
	END
GO
