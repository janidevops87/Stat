/***************************************************************************************************
**	Name: TcssDonorContactInformation
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorContactInformation
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorContactInformation')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorContactInformation'
	ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT PK_TcssDonorContactInformation PRIMARY KEY Clustered (TcssDonorContactInformationId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorContactInformation_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorContactInformation_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorContactInformation_TcssDonorId ON dbo.TcssDonorContactInformation (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorContactInformation_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorContactInformation_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorContactInformation ADD CONSTRAINT DF_TcssDonorContactInformation_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
