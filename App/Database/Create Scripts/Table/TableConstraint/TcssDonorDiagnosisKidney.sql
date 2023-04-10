/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidney
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisKidney')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisKidney'
	ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT PK_TcssDonorDiagnosisKidney PRIMARY KEY Clustered (TcssDonorDiagnosisKidneyId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisKidney_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisKidney_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisKidney ADD CONSTRAINT DF_TcssDonorDiagnosisKidney_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisKidney_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisKidney_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisKidney_TcssDonorId ON dbo.TcssDonorDiagnosisKidney (TcssDonorId) ON IDX
END
GO
