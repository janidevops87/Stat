/***************************************************************************************************
**	Name: TcssDonorTest
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorTest
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorTest')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorTest'
	ALTER TABLE dbo.TcssDonorTest ADD CONSTRAINT PK_TcssDonorTest PRIMARY KEY Clustered (TcssDonorTestId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorTest_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorTest_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorTest ADD CONSTRAINT DF_TcssDonorTest_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorTest_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorTest_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorTest_TcssDonorId ON dbo.TcssDonorTest (TcssDonorId) ON IDX
END
GO
