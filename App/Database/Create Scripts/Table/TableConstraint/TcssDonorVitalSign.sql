/***************************************************************************************************
**	Name: TcssDonorVitalSign
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssDonorVitalSign
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/06/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssDonorVitalSign')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssDonorVitalSign'
	ALTER TABLE dbo.TcssDonorVitalSign ADD CONSTRAINT PK_TcssDonorVitalSign PRIMARY KEY Clustered (TcssDonorVitalSignId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssDonorVitalSign_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssDonorVitalSign_LastUpdateDate'
	ALTER TABLE dbo.TcssDonorVitalSign ADD CONSTRAINT DF_TcssDonorVitalSign_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE NAME = 'IX_TcssDonorVitalSign_TcssDonorId')
BEGIN
	PRINT 'Creating Index IX_TcssDonorVitalSign_TcssDonorId'
	CREATE NonClustered INDEX IX_TcssDonorVitalSign_TcssDonorId ON dbo.TcssDonorVitalSign (TcssDonorId) ON IDX
END
GO
