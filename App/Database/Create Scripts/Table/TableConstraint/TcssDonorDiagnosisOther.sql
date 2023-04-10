/***************************************************************************************************
**	Name: TcssDonorDiagnosisOther
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisOther
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisOther')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisOther'
	ALTER TABLE dbo.TcssDonorDiagnosisOther ADD CONSTRAINT PK_TcssDonorDiagnosisOther PRIMARY KEY Clustered (TcssDonorDiagnosisOtherId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisOther_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisOther_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisOther ADD CONSTRAINT DF_TcssDonorDiagnosisOther_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisOther_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorDiagnosisOther_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorDiagnosisOther_TcssDonorId ON dbo.TcssDonorDiagnosisOther (TcssDonorId) ON IDX
END
GO
