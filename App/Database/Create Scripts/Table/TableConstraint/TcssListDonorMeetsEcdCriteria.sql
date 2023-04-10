/***************************************************************************************************
**	Name: TcssListDonorMeetsEcdCriteria
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorMeetsEcdCriteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorMeetsEcdCriteria')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorMeetsEcdCriteria'
	ALTER TABLE dbo.TcssListDonorMeetsEcdCriteria ADD CONSTRAINT PK_TcssListDonorMeetsEcdCriteria PRIMARY KEY Clustered (TcssListDonorMeetsEcdCriteriaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsEcdCriteria_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsEcdCriteria_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorMeetsEcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsEcdCriteria_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsEcdCriteria_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsEcdCriteria_SortOrder'
	ALTER TABLE dbo.TcssListDonorMeetsEcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsEcdCriteria_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorMeetsEcdCriteria_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorMeetsEcdCriteria_IsActive'
	ALTER TABLE dbo.TcssListDonorMeetsEcdCriteria ADD CONSTRAINT DF_TcssListDonorMeetsEcdCriteria_IsActive DEFAULT(1) FOR IsActive
END
GO
