/***************************************************************************************************
**	Name: TcssListOrganType
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListOrganType
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListOrganType')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListOrganType'
	ALTER TABLE dbo.TcssListOrganType ADD CONSTRAINT PK_TcssListOrganType PRIMARY KEY Clustered (TcssListOrganTypeId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOrganType_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOrganType_LastUpdateDate'
	ALTER TABLE dbo.TcssListOrganType ADD CONSTRAINT DF_TcssListOrganType_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOrganType_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOrganType_SortOrder'
	ALTER TABLE dbo.TcssListOrganType ADD CONSTRAINT DF_TcssListOrganType_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListOrganType_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListOrganType_IsActive'
	ALTER TABLE dbo.TcssListOrganType ADD CONSTRAINT DF_TcssListOrganType_IsActive DEFAULT(1) FOR IsActive
END
GO
