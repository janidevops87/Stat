/***************************************************************************************************
**	Name: TcssDonorTest
**	Desc: Add Foreign keys to TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorTest_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorTest_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorTest ADD CONSTRAINT FK_TcssDonorTest_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorTest_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorTest_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorTest ADD CONSTRAINT FK_TcssDonorTest_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorTest_TcssListTestTypeId_TcssListTestType_TcssListTestTypeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorTest_TcssListTestTypeId_TcssListTestType_TcssListTestTypeId'
		ALTER TABLE dbo.TcssDonorTest ADD CONSTRAINT FK_TcssDonorTest_TcssListTestTypeId_TcssListTestType_TcssListTestTypeId
			FOREIGN KEY(TcssListTestTypeId) REFERENCES dbo.TcssListTestType(TcssListTestTypeId) 
	END
GO
