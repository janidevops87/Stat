/***************************************************************************************************
**	Name: TcssDonorUrinalysis
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorUrinalysis
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorUrinalysis')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorUrinalysis'
	ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT PK_TcssDonorUrinalysis PRIMARY KEY Clustered (TcssDonorUrinalysisId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorUrinalysis_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorUrinalysis_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorUrinalysis ADD CONSTRAINT DF_TcssDonorUrinalysis_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorUrinalysis_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorUrinalysis_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorUrinalysis_TcssDonorId ON dbo.TcssDonorUrinalysis (TcssDonorId) ON IDX
END
GO
