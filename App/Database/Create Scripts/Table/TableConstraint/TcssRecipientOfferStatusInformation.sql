/***************************************************************************************************
**	Name: TcssRecipientOfferStatusInformation
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientOfferStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientOfferStatusInformation')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientOfferStatusInformation'
	ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT PK_TcssRecipientOfferStatusInformation PRIMARY KEY Clustered (TcssRecipientOfferStatusInformationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientOfferStatusInformation_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientOfferStatusInformation_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientOfferStatusInformation ADD CONSTRAINT DF_TcssRecipientOfferStatusInformation_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
