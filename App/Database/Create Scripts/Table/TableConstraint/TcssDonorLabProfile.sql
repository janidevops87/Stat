/***************************************************************************************************
**	Name: TcssDonorLabProfile
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorLabProfile
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorLabProfile')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorLabProfile'
	ALTER TABLE dbo.TcssDonorLabProfile ADD CONSTRAINT PK_TcssDonorLabProfile PRIMARY KEY Clustered (TcssDonorLabProfileId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorLabProfile_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorLabProfile_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorLabProfile ADD CONSTRAINT DF_TcssDonorLabProfile_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorLabProfile_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorLabProfile_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorLabProfile_TcssDonorId ON dbo.TcssDonorLabProfile (TcssDonorId) ON IDX
END
GO
