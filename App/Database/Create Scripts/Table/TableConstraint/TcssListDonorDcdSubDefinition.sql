/***************************************************************************************************
**	Name: TcssListDonorDcdSubDefinition
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorDcdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorDcdSubDefinition')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorDcdSubDefinition'
	ALTER TABLE dbo.TcssListDonorDcdSubDefinition ADD CONSTRAINT PK_TcssListDonorDcdSubDefinition PRIMARY KEY Clustered (TcssListDonorDcdSubDefinitionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDcdSubDefinition_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDcdSubDefinition_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorDcdSubDefinition ADD CONSTRAINT DF_TcssListDonorDcdSubDefinition_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDcdSubDefinition_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDcdSubDefinition_SortOrder'
	ALTER TABLE dbo.TcssListDonorDcdSubDefinition ADD CONSTRAINT DF_TcssListDonorDcdSubDefinition_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDcdSubDefinition_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDcdSubDefinition_IsActive'
	ALTER TABLE dbo.TcssListDonorDcdSubDefinition ADD CONSTRAINT DF_TcssListDonorDcdSubDefinition_IsActive DEFAULT(1) FOR IsActive
END
GO
