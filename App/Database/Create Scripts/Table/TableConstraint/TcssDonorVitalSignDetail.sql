/***************************************************************************************************
**	Name: TcssDonorVitalSignDetail
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorVitalSignDetail
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorVitalSignDetail')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorVitalSignDetail'
	ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT PK_TcssDonorVitalSignDetail PRIMARY KEY Clustered (TcssDonorVitalSignDetailId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorVitalSignDetail_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorVitalSignDetail_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorVitalSignDetail ADD CONSTRAINT DF_TcssDonorVitalSignDetail_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorVitalSignDetail_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorVitalSignDetail_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorVitalSignDetail_TcssDonorId ON dbo.TcssDonorVitalSignDetail (TcssDonorId) ON IDX
END
GO
