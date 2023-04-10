/***************************************************************************************************
**	Name: TcssRecipientHlaLiver
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssRecipientHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	07/07/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssRecipientHlaLiver')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssRecipientHlaLiver'
	ALTER TABLE dbo.TcssRecipientHlaLiver ADD CONSTRAINT PK_TcssRecipientHlaLiver PRIMARY KEY Clustered (TcssRecipientHlaLiverId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssRecipientHlaLiver_TcssRecipientId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssRecipientHlaLiver_TcssRecipientId'
	CREATE UNIQUE NonClustered INDEX IX_TcssRecipientHlaLiver_TcssRecipientId ON dbo.TcssRecipientHlaLiver (TcssRecipientId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssRecipientHlaLiver_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssRecipientHlaLiver_LastUpdateDate'
	ALTER TABLE dbo.TcssRecipientHlaLiver ADD CONSTRAINT DF_TcssRecipientHlaLiver_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
