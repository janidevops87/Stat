/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyBiopsy
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisKidneyBiopsy
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisKidneyBiopsy')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisKidneyBiopsy'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyBiopsy ADD CONSTRAINT PK_TcssDonorDiagnosisKidneyBiopsy PRIMARY KEY Clustered (TcssDonorDiagnosisKidneyBiopsyId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisKidneyBiopsy_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisKidneyBiopsy_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyBiopsy ADD CONSTRAINT DF_TcssDonorDiagnosisKidneyBiopsy_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisKidneyBiopsy_TcssDonorId ON dbo.TcssDonorDiagnosisKidneyBiopsy (TcssDonorId) ON IDX
END
GO
