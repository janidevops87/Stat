/***************************************************************************************************
**	Name: TcssDonorStatusInformation
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorStatusInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorStatusInformation')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorStatusInformation'
	ALTER TABLE dbo.TcssDonorStatusInformation ADD CONSTRAINT PK_TcssDonorStatusInformation PRIMARY KEY Clustered (TcssDonorStatusInformationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorStatusInformation_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorStatusInformation_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorStatusInformation ADD CONSTRAINT DF_TcssDonorStatusInformation_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorStatusInformation_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorStatusInformation_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorStatusInformation_TcssDonorId ON dbo.TcssDonorStatusInformation (TcssDonorId) ON IDX
END
GO
