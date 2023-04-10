/***************************************************************************************************
**	Name: TcssDonorHla
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorHla
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/22/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorHla')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorHla'
	ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT PK_TcssDonorHla PRIMARY KEY Clustered (TcssDonorHlaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorHla_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorHla_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorHla_TcssDonorId ON dbo.TcssDonorHla (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorHla_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorHla_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorHla ADD CONSTRAINT DF_TcssDonorHla_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
