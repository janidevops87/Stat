/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyArtery
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisKidneyArtery
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisKidneyArtery')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisKidneyArtery'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT PK_TcssDonorDiagnosisKidneyArtery PRIMARY KEY Clustered (TcssDonorDiagnosisKidneyArteryId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisKidneyArtery_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisKidneyArtery_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyArtery ADD CONSTRAINT DF_TcssDonorDiagnosisKidneyArtery_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisKidneyArtery_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisKidneyArtery_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisKidneyArtery_TcssDonorId ON dbo.TcssDonorDiagnosisKidneyArtery (TcssDonorId) ON IDX
END
GO
