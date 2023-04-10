/***************************************************************************************************
**	Name: TcssDonorLabValues
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorLabValues
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorLabValues')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorLabValues'
	ALTER TABLE dbo.TcssDonorLabValues ADD CONSTRAINT PK_TcssDonorLabValues PRIMARY KEY Clustered (TcssDonorLabValuesId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorLabValues_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorLabValues_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorLabValues ADD CONSTRAINT DF_TcssDonorLabValues_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorLabValues_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorLabValues_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorLabValues_TcssDonorId ON dbo.TcssDonorLabValues (TcssDonorId) ON IDX
END
GO
