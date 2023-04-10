/***************************************************************************************************
**	Name: TcssDonorDiagnosisLung
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisLung
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisLung')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisLung'
	ALTER TABLE dbo.TcssDonorDiagnosisLung ADD CONSTRAINT PK_TcssDonorDiagnosisLung PRIMARY KEY Clustered (TcssDonorDiagnosisLungId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisLung_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorDiagnosisLung_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorDiagnosisLung_TcssDonorId ON dbo.TcssDonorDiagnosisLung (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisLung_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisLung_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisLung ADD CONSTRAINT DF_TcssDonorDiagnosisLung_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
