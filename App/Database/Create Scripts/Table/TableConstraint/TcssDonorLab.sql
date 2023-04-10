/***************************************************************************************************
**	Name: TcssDonorLab
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorLab
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorLab')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorLab'
	ALTER TABLE dbo.TcssDonorLab ADD CONSTRAINT PK_TcssDonorLab PRIMARY KEY Clustered (TcssDonorLabId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorLab_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorLab_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorLab_TcssDonorId ON dbo.TcssDonorLab (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorLab_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorLab_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorLab ADD CONSTRAINT DF_TcssDonorLab_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
