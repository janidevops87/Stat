/***************************************************************************************************
**	Name: TcssListDonorDefinition
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorDefinition')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorDefinition'
	ALTER TABLE dbo.TcssListDonorDefinition ADD CONSTRAINT PK_TcssListDonorDefinition PRIMARY KEY Clustered (TcssListDonorDefinitionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDefinition_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDefinition_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorDefinition ADD CONSTRAINT DF_TcssListDonorDefinition_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDefinition_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDefinition_SortOrder'
	ALTER TABLE dbo.TcssListDonorDefinition ADD CONSTRAINT DF_TcssListDonorDefinition_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDefinition_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDefinition_IsActive'
	ALTER TABLE dbo.TcssListDonorDefinition ADD CONSTRAINT DF_TcssListDonorDefinition_IsActive DEFAULT(1) FOR IsActive
END
GO
