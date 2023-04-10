/***************************************************************************************************
**	Name: TcssDonorSerologies
**	Desc: Add Foreign keys to TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorSerologies_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorSerologies_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT FK_TcssDonorSerologies_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorSerologies_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorSerologies_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT FK_TcssDonorSerologies_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorSerologies_TcssListSerologyQuestionId_TcssListSerologyQuestion_TcssListSerologyQuestionId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorSerologies_TcssListSerologyQuestionId_TcssListSerologyQuestion_TcssListSerologyQuestionId'
		ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT FK_TcssDonorSerologies_TcssListSerologyQuestionId_TcssListSerologyQuestion_TcssListSerologyQuestionId
			FOREIGN KEY(TcssListSerologyQuestionId) REFERENCES dbo.TcssListSerologyQuestion(TcssListSerologyQuestionId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorSerologies_TcssListSerologyAnswerId_TcssListSerologyAnswer_TcssListSerologyAnswerId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorSerologies_TcssListSerologyAnswerId_TcssListSerologyAnswer_TcssListSerologyAnswerId'
		ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT FK_TcssDonorSerologies_TcssListSerologyAnswerId_TcssListSerologyAnswer_TcssListSerologyAnswerId
			FOREIGN KEY(TcssListSerologyAnswerId) REFERENCES dbo.TcssListSerologyAnswer(TcssListSerologyAnswerId) 
	END
GO
