/***************************************************************************************************
**	Name: TcssDonorMedSoc
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorMedSoc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorMedSoc')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorMedSoc'
	ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT PK_TcssDonorMedSoc PRIMARY KEY Clustered (TcssDonorMedSocId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorMedSoc_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorMedSoc_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorMedSoc_TcssDonorId ON dbo.TcssDonorMedSoc (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorMedSoc_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorMedSoc_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorMedSoc ADD CONSTRAINT DF_TcssDonorMedSoc_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
