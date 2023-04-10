/***************************************************************************************************
**	Name: TcssDonorDiagnosisPancreas
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorDiagnosisPancreas
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorDiagnosisPancreas')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorDiagnosisPancreas'
	ALTER TABLE dbo.TcssDonorDiagnosisPancreas ADD CONSTRAINT PK_TcssDonorDiagnosisPancreas PRIMARY KEY Clustered (TcssDonorDiagnosisPancreasId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorDiagnosisPancreas_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorDiagnosisPancreas_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorDiagnosisPancreas_TcssDonorId ON dbo.TcssDonorDiagnosisPancreas (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorDiagnosisPancreas_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorDiagnosisPancreas_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorDiagnosisPancreas ADD CONSTRAINT DF_TcssDonorDiagnosisPancreas_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
