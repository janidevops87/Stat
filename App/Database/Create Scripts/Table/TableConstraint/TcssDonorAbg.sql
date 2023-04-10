/***************************************************************************************************
**	Name: TcssDonorAbg
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorAbg
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorAbg')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorAbg'
	ALTER TABLE dbo.TcssDonorAbg ADD CONSTRAINT PK_TcssDonorAbg PRIMARY KEY Clustered (TcssDonorAbgId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorAbg_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorAbg_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorAbg ADD CONSTRAINT DF_TcssDonorAbg_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorAbg_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorAbg_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorAbg_TcssDonorId ON dbo.TcssDonorAbg (TcssDonorId) ON IDX
END
GO
