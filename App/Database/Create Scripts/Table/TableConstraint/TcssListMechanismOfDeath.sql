/***************************************************************************************************
**	Name: TcssListMechanismOfDeath
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListMechanismOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListMechanismOfDeath')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListMechanismOfDeath'
	ALTER TABLE dbo.TcssListMechanismOfDeath ADD CONSTRAINT PK_TcssListMechanismOfDeath PRIMARY KEY Clustered (TcssListMechanismOfDeathId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMechanismOfDeath_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMechanismOfDeath_LastUpdateDate'
	ALTER TABLE dbo.TcssListMechanismOfDeath ADD CONSTRAINT DF_TcssListMechanismOfDeath_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMechanismOfDeath_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMechanismOfDeath_SortOrder'
	ALTER TABLE dbo.TcssListMechanismOfDeath ADD CONSTRAINT DF_TcssListMechanismOfDeath_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListMechanismOfDeath_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListMechanismOfDeath_IsActive'
	ALTER TABLE dbo.TcssListMechanismOfDeath ADD CONSTRAINT DF_TcssListMechanismOfDeath_IsActive DEFAULT(1) FOR IsActive
END
GO
