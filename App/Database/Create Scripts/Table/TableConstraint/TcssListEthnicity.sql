/***************************************************************************************************
**	Name: TcssListEthnicity
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListEthnicity
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListEthnicity')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListEthnicity'
	ALTER TABLE dbo.TcssListEthnicity ADD CONSTRAINT PK_TcssListEthnicity PRIMARY KEY Clustered (TcssListEthnicityId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListEthnicity_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListEthnicity_LastUpdateDate'
	ALTER TABLE dbo.TcssListEthnicity ADD CONSTRAINT DF_TcssListEthnicity_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListEthnicity_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListEthnicity_SortOrder'
	ALTER TABLE dbo.TcssListEthnicity ADD CONSTRAINT DF_TcssListEthnicity_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListEthnicity_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListEthnicity_IsActive'
	ALTER TABLE dbo.TcssListEthnicity ADD CONSTRAINT DF_TcssListEthnicity_IsActive DEFAULT(1) FOR IsActive
END
GO
