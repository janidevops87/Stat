/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyUreter
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisKidneyUreter
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisKidneyUreter')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisKidneyUreter'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT PK_TcssDonorDiagnosisKidneyUreter PRIMARY KEY Clustered (TcssDonorDiagnosisKidneyUreterId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisKidneyUreter_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisKidneyUreter_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyUreter ADD CONSTRAINT DF_TcssDonorDiagnosisKidneyUreter_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisKidneyUreter_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisKidneyUreter_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisKidneyUreter_TcssDonorId ON dbo.TcssDonorDiagnosisKidneyUreter (TcssDonorId) ON IDX
END
GO
