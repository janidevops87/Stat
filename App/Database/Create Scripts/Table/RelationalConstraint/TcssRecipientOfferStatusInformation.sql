/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformation
**	Desc: Add Foreign keys to TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT FK_TcssRecipientOfferStatusInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferStatusInformation_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferStatusInformation_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT FK_TcssRecipientOfferStatusInformation_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId'
		ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT FK_TcssRecipientOfferStatusInformation_TcssListStatusId_TcssListStatus_TcssListStatusId
			FOREIGN KEY(TcssListStatusId) REFERENCES dbo.TcssListStatus(TcssListStatusId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientOfferStatusInformation_CoordinatorId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientOfferStatusInformation_CoordinatorId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT FK_TcssRecipientOfferStatusInformation_CoordinatorId_StatEmployee_StatEmployeeId
			FOREIGN KEY(CoordinatorId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO
