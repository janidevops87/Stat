/***************************************************************************************************
**	Name: TcssDonorLabProfileDetail
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorLabProfileDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorLabProfileDetail')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorLabProfileDetail'
	ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT PK_TcssDonorLabProfileDetail PRIMARY KEY Clustered (TcssDonorLabProfileDetailId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorLabProfileDetail_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorLabProfileDetail_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorLabProfileDetail ADD CONSTRAINT DF_TcssDonorLabProfileDetail_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorLabProfileDetail_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorLabProfileDetail_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorLabProfileDetail_TcssDonorId ON dbo.TcssDonorLabProfileDetail (TcssDonorId) ON IDX
END
GO
