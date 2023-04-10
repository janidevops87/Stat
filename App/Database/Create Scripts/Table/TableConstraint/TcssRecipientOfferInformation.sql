/***************************************************************************************************
**	Name: TcssRecipientOfferInformation
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientOfferInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientOfferInformation')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientOfferInformation'
	ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT PK_TcssRecipientOfferInformation PRIMARY KEY Clustered (TcssRecipientOfferInformationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssRecipientOfferInformation_CallId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssRecipientOfferInformation_CallId'
	CREATE UNIQUE NonClustered INDEX IX_TcssRecipientOfferInformation_CallId ON dbo.TcssRecipientOfferInformation (CallId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientOfferInformation_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientOfferInformation_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT DF_TcssRecipientOfferInformation_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientOfferInformation_CloseDate1')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientOfferInformation_CloseDate1'
	ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT DF_TcssRecipientOfferInformation_CloseDate1 DEFAULT(GetUtcDate()) FOR CloseDate1
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientOfferInformation_CloseDate2')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientOfferInformation_CloseDate2'
	ALTER TABLE dbo.TcssRecipientOfferInformation ADD CONSTRAINT DF_TcssRecipientOfferInformation_CloseDate2 DEFAULT(GetUtcDate()) FOR CloseDate2
END
GO
