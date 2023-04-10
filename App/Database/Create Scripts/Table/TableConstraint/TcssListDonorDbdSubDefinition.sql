/***************************************************************************************************
**	Name: TcssListDonorDbdSubDefinition
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListDonorDbdSubDefinition
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListDonorDbdSubDefinition')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListDonorDbdSubDefinition'
	ALTER TABLE dbo.TcssListDonorDbdSubDefinition ADD CONSTRAINT PK_TcssListDonorDbdSubDefinition PRIMARY KEY Clustered (TcssListDonorDbdSubDefinitionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDbdSubDefinition_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDbdSubDefinition_LastUpdateDate'
	ALTER TABLE dbo.TcssListDonorDbdSubDefinition ADD CONSTRAINT DF_TcssListDonorDbdSubDefinition_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDbdSubDefinition_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDbdSubDefinition_SortOrder'
	ALTER TABLE dbo.TcssListDonorDbdSubDefinition ADD CONSTRAINT DF_TcssListDonorDbdSubDefinition_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListDonorDbdSubDefinition_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListDonorDbdSubDefinition_IsActive'
	ALTER TABLE dbo.TcssListDonorDbdSubDefinition ADD CONSTRAINT DF_TcssListDonorDbdSubDefinition_IsActive DEFAULT(1) FOR IsActive
END
GO
