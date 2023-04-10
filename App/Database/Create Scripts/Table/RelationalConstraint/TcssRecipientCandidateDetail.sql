/***************************************************************************************************
**	Name: TcssRecipientCandidateDetail
**	Desc: Add Foreign keys to TcssRecipientCandidateDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidateDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidateDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT FK_TcssRecipientCandidateDetail_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidateDetail_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidateDetail_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT FK_TcssRecipientCandidateDetail_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidateDetail_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidateDetail_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId'
		ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT FK_TcssRecipientCandidateDetail_TcssListOfferStatusId_TcssListOfferStatus_TcssListOfferStatusId
			FOREIGN KEY(TcssListOfferStatusId) REFERENCES dbo.TcssListOfferStatus(TcssListOfferStatusId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidateDetail_PrimaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidateDetail_PrimaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId'
		ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT FK_TcssRecipientCandidateDetail_PrimaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId
			FOREIGN KEY(PrimaryTcssListRefusalReasonId) REFERENCES dbo.TcssListRefusalReason(TcssListRefusalReasonId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientCandidateDetail_SecondaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientCandidateDetail_SecondaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId'
		ALTER TABLE dbo.TcssRecipientCandidateDetail ADD CONSTRAINT FK_TcssRecipientCandidateDetail_SecondaryTcssListRefusalReasonId_TcssListRefusalReason_TcssListRefusalReasonId
			FOREIGN KEY(SecondaryTcssListRefusalReasonId) REFERENCES dbo.TcssListRefusalReason(TcssListRefusalReasonId) 
	END
GO
