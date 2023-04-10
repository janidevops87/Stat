/***************************************************************************************************
**	Name: TcssDonorDiagnosisIntestine
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisIntestine
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisIntestine')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisIntestine'
	ALTER TABLE dbo.TcssDonorDiagnosisIntestine ADD CONSTRAINT PK_TcssDonorDiagnosisIntestine PRIMARY KEY Clustered (TcssDonorDiagnosisIntestineId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisIntestine_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorDiagnosisIntestine_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorDiagnosisIntestine_TcssDonorId ON dbo.TcssDonorDiagnosisIntestine (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisIntestine_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisIntestine_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisIntestine ADD CONSTRAINT DF_TcssDonorDiagnosisIntestine_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
