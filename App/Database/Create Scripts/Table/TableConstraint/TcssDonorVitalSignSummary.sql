/***************************************************************************************************
**	Name: TcssDonorVitalSignSummary
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorVitalSignSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorVitalSignSummary')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorVitalSignSummary'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD CONSTRAINT PK_TcssDonorVitalSignSummary PRIMARY KEY Clustered (TcssDonorVitalSignSummaryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorVitalSignSummary_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorVitalSignSummary_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorVitalSignSummary ADD CONSTRAINT DF_TcssDonorVitalSignSummary_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorVitalSignSummary_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorVitalSignSummary_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorVitalSignSummary_TcssDonorId ON dbo.TcssDonorVitalSignSummary (TcssDonorId) ON IDX
END
GO
