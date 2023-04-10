/***************************************************************************************************
**	Name: TcssDonorDiagnosisKidneyVein
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisKidneyVein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisKidneyVein')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisKidneyVein'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT PK_TcssDonorDiagnosisKidneyVein PRIMARY KEY Clustered (TcssDonorDiagnosisKidneyVeinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisKidneyVein_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisKidneyVein_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisKidneyVein ADD CONSTRAINT DF_TcssDonorDiagnosisKidneyVein_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisKidneyVein_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisKidneyVein_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisKidneyVein_TcssDonorId ON dbo.TcssDonorDiagnosisKidneyVein (TcssDonorId) ON IDX
END
GO
