/***************************************************************************************************
**	Name: TcssDonorDiagnosisLiver
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisLiver')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisLiver'
	ALTER TABLE dbo.TcssDonorDiagnosisLiver ADD CONSTRAINT PK_TcssDonorDiagnosisLiver PRIMARY KEY Clustered (TcssDonorDiagnosisLiverId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisLiver_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorDiagnosisLiver_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorDiagnosisLiver_TcssDonorId ON dbo.TcssDonorDiagnosisLiver (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisLiver_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisLiver_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisLiver ADD CONSTRAINT DF_TcssDonorDiagnosisLiver_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
