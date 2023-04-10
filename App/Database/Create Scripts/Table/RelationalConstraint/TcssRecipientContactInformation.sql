/***************************************************************************************************
**	Name: TcssRecipientContactInformation
**	Desc: Add Foreign keys to TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId'
		ALTER TABLE dbo.TcssRecipientContactInformation ADD CONSTRAINT FK_TcssRecipientContactInformation_LastUpdateStatEmployeeId_StatEmployee_StatEmployeeId
			FOREIGN KEY(LastUpdateStatEmployeeId) REFERENCES dbo.StatEmployee(StatEmployeeId) 
	END
GO

IF NOT EXISTS (SELECT * FROM sysobjects WHERE type = 'F' AND name = 'FK_TcssRecipientContactInformation_TcssRecipientId_TcssRecipient_TcssRecipientId')
	BEGIN
		PRINT 'Adding Foreign Key FK_TcssRecipientContactInformation_TcssRecipientId_TcssRecipient_TcssRecipientId'
		ALTER TABLE dbo.TcssRecipientContactInformation ADD CONSTRAINT FK_TcssRecipientContactInformation_TcssRecipientId_TcssRecipient_TcssRecipientId
			FOREIGN KEY(TcssRecipientId) REFERENCES dbo.TcssRecipient(TcssRecipientId) 
	END
GO
