/***************************************************************************************************
**	Name: TcssDonorDiagnosisHeart
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisHeart
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisHeart')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisHeart'
	ALTER TABLE dbo.TcssDonorDiagnosisHeart ADD CONSTRAINT PK_TcssDonorDiagnosisHeart PRIMARY KEY Clustered (TcssDonorDiagnosisHeartId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisHeart_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorDiagnosisHeart_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorDiagnosisHeart_TcssDonorId ON dbo.TcssDonorDiagnosisHeart (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisHeart_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisHeart_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisHeart ADD CONSTRAINT DF_TcssDonorDiagnosisHeart_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
