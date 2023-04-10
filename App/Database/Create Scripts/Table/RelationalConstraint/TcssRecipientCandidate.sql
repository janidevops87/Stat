/***************************************************************************************************
**	Name: TcssRecipientCandidate
**	Desc: Add Foreign keys to TcssRecipientCandidate
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidate_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidate_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientCandidate ADD CONSTRAINT FK_TcssRecipientCandidate_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidate_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidate_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientCandidate ADD CONSTRAINT FK_TcssRecipientCandidate_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId'
		ALTER TABLE dbo.TcssRecipientCandidate ADD CONSTRAINT FK_TcssRecipientCandidate_TcssListRefusedByOtherCenterId_TcssListRefusedByOtherCenter_TcssListRefusedByOtherCenterId
			FOREIGN KEY(TcssListRefusedByOtherCenterId) REFERENCES dbo.TcssListRefusedByOtherCenter(TcssListRefusedByOtherCenterId) 
	END
GO


