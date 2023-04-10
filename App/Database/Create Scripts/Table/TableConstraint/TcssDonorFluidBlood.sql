/***************************************************************************************************
**	Name: TcssDonorFluidBlood
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorFluidBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorFluidBlood')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorFluidBlood'
	ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT PK_TcssDonorFluidBlood PRIMARY KEY Clustered (TcssDonorFluidBloodId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorFluidBlood_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorFluidBlood_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorFluidBlood_TcssDonorId ON dbo.TcssDonorFluidBlood (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorFluidBlood_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorFluidBlood_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorFluidBlood ADD CONSTRAINT DF_TcssDonorFluidBlood_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
