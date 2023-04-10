/***************************************************************************************************
**	Name: TcssDonorCompleteBloodCount
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorCompleteBloodCount
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorCompleteBloodCount')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorCompleteBloodCount'
	ALTER TABLE dbo.TcssDonorCompleteBloodCount ADD CONSTRAINT PK_TcssDonorCompleteBloodCount PRIMARY KEY Clustered (TcssDonorCompleteBloodCountId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorCompleteBloodCount_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorCompleteBloodCount_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorCompleteBloodCount ADD CONSTRAINT DF_TcssDonorCompleteBloodCount_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorCompleteBloodCount_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorCompleteBloodCount_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorCompleteBloodCount_TcssDonorId ON dbo.TcssDonorCompleteBloodCount (TcssDonorId) ON IDX
END
GO
