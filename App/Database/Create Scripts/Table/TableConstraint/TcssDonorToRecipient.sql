/***************************************************************************************************
**	Name: TcssDonorToRecipient
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorToRecipient
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorToRecipient')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorToRecipient'
	ALTER TABLE dbo.TcssDonorToRecipient ADD CONSTRAINT PK_TcssDonorToRecipient PRIMARY KEY Clustered (TcssDonorToRecipientId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorToRecipient_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorToRecipient_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorToRecipient ADD CONSTRAINT DF_TcssDonorToRecipient_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorToRecipient_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorToRecipient_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorToRecipient_TcssDonorId ON dbo.TcssDonorToRecipient (TcssDonorId) ON IDX
END
GO
