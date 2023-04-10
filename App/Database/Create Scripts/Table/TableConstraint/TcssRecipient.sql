/***************************************************************************************************
**	Name: TcssRecipient
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipient')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipient'
	ALTER TABLE dbo.TcssRecipient ADD CONSTRAINT PK_TcssRecipient PRIMARY KEY Clustered (TcssRecipientId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipient_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipient_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipient ADD CONSTRAINT DF_TcssRecipient_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
