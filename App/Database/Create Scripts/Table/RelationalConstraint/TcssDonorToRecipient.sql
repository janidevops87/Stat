/***************************************************************************************************
**	Name: TcssDonorToRecipient
**	Desc: Add Foreign keys to TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorToRecipient_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorToRecipient_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssDonorToRecipient ADD CONSTRAINT FK_TcssDonorToRecipient_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorToRecipient_TcssDonorId_TcssDonor_TcssDonorId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorToRecipient_TcssDonorId_TcssDonor_TcssDonorId'
		ALTER TABLE dbo.TcssDonorToRecipient ADD CONSTRAINT FK_TcssDonorToRecipient_TcssDonorId_TcssDonor_TcssDonorId
			FOREIGN KEY(TcssDonorId) REFERENCES dbo.TcssDonor(TcssDonorId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssDonorToRecipient_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssDonorToRecipient_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssDonorToRecipient ADD CONSTRAINT FK_TcssDonorToRecipient_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO
