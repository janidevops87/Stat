/***************************************************************************************************
**	Name: TcssDonorAbgSummary
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorAbgSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorAbgSummary')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorAbgSummary'
	ALTER TABLE dbo.TcssDonorAbgSummary ADD CONSTRAINT PK_TcssDonorAbgSummary PRIMARY KEY Clustered (TcssDonorAbgSummaryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorAbgSummary_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorAbgSummary_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorAbgSummary ADD CONSTRAINT DF_TcssDonorAbgSummary_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorAbgSummary_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorAbgSummary_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorAbgSummary_TcssDonorId ON dbo.TcssDonorAbgSummary (TcssDonorId) ON IDX
END
GO
