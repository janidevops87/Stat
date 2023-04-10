/***************************************************************************************************
**	Name: TcssRecipientContactInformation
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientContactInformation')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientContactInformation'
	ALTER TABLE dbo.TcssRecipientContactInformation ADD CONSTRAINT PK_TcssRecipientContactInformation PRIMARY KEY Clustered (TcssRecipientContactInformationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssRecipientContactInformation_TcssRecipientId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssRecipientContactInformation_TcssRecipientId'
	CREATE UNIQUE NonClustered INDEX IX_TcssRecipientContactInformation_TcssRecipientId ON dbo.TcssRecipientContactInformation (TcssRecipientId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientContactInformation_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientContactInformation_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientContactInformation ADD CONSTRAINT DF_TcssRecipientContactInformation_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
