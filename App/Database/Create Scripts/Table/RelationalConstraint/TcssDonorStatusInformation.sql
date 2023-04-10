/***************************************************************************************************
**	Name: TcssDonorStatusInformation
**	Desc: Add Foreign keys to TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorStatusInformation ADD CONSTRAINT FK_TcssDonorStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorStatusInformation_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorStatusInformation_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorStatusInformation ADD CONSTRAINT FK_TcssDonorStatusInformation_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId'
		ALTER TABLE dbo.TcssDonorStatusInformation ADD CONSTRAINT FK_TcssDonorStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId
			FOREIGN KEY(TcssListStatusId) REFERENCES dbo.TcssListStatus(TcssListStatusId) 
	END
GO
