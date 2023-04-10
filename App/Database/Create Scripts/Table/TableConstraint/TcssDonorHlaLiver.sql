/***************************************************************************************************
**	Name: TcssDonorHlaLiver
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorHlaLiver
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorHlaLiver')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorHlaLiver'
	ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT PK_TcssDonorHlaLiver PRIMARY KEY Clustered (TcssDonorHlaLiverId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorHlaLiver_TcssDonorId')
BEGIN
	PRINT 'Creating Unique Constraint IX_TcssDonorHlaLiver_TcssDonorId'
	CREATE UNIQUE NonClustered INDEX IX_TcssDonorHlaLiver_TcssDonorId ON dbo.TcssDonorHlaLiver (TcssDonorId) ON IDX
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorHlaLiver_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorHlaLiver_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorHlaLiver ADD CONSTRAINT DF_TcssDonorHlaLiver_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO
