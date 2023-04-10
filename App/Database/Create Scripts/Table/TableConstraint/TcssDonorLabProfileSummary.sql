/***************************************************************************************************
**	Name: TcssDonorLabProfileSummary
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorLabProfileSummary
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorLabProfileSummary')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorLabProfileSummary'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD CONSTRAINT PK_TcssDonorLabProfileSummary PRIMARY KEY Clustered (TcssDonorLabProfileSummaryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorLabProfileSummary_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorLabProfileSummary_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorLabProfileSummary ADD CONSTRAINT DF_TcssDonorLabProfileSummary_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorLabProfileSummary_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorLabProfileSummary_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorLabProfileSummary_TcssDonorId ON dbo.TcssDonorLabProfileSummary (TcssDonorId) ON IDX
END
GO
