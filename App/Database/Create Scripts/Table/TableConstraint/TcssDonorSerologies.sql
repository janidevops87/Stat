/***************************************************************************************************
**	Name: TcssDonorSerologies
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorSerologies
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorSerologies')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorSerologies'
	ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT PK_TcssDonorSerologies PRIMARY KEY Clustered (TcssDonorSerologiesId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorSerologies_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorSerologies_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorSerologies ADD CONSTRAINT DF_TcssDonorSerologies_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorSerologies_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorSerologies_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorSerologies_TcssDonorId ON dbo.TcssDonorSerologies (TcssDonorId) ON IDX
END
GO
