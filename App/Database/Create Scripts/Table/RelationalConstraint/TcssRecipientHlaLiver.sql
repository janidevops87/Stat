/***************************************************************************************************
**	Name: TcssRecipientHlaLiver
**	Desc: Add Foreign keys to TcssRecipientHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientHlaLiver ADD CONSTRAINT FK_TcssRecipientHlaLiver_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientHlaLiver_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientHlaLiver_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientHlaLiver ADD CONSTRAINT FK_TcssRecipientHlaLiver_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientHlaLiver_TcssListScdId_TcssListScd_TcssListScdId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientHlaLiver_TcssListScdId_TcssListScd_TcssListScdId'
		ALTER TABLE dbo.TcssRecipientHlaLiver ADD CONSTRAINT FK_TcssRecipientHlaLiver_TcssListScdId_TcssListScd_TcssListScdId
			FOREIGN KEY(TcssListScdId) REFERENCES dbo.TcssListScd(TcssListScdId) 
	END
GO
