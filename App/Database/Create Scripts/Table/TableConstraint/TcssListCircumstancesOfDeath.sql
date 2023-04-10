/***************************************************************************************************
**	Name: TcssListCircumstancesOfDeath
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCircumstancesOfDeath
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCircumstancesOfDeath')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCircumstancesOfDeath'
	ALTER TABLE dbo.TcssListCircumstancesOfDeath ADD CONSTRAINT PK_TcssListCircumstancesOfDeath PRIMARY KEY Clustered (TcssListCircumstancesOfDeathId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCircumstancesOfDeath_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCircumstancesOfDeath_LastUpdateDate'
	ALTER TABLE dbo.TcssListCircumstancesOfDeath ADD CONSTRAINT DF_TcssListCircumstancesOfDeath_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCircumstancesOfDeath_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCircumstancesOfDeath_SortOrder'
	ALTER TABLE dbo.TcssListCircumstancesOfDeath ADD CONSTRAINT DF_TcssListCircumstancesOfDeath_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCircumstancesOfDeath_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCircumstancesOfDeath_IsActive'
	ALTER TABLE dbo.TcssListCircumstancesOfDeath ADD CONSTRAINT DF_TcssListCircumstancesOfDeath_IsActive DEFAULT(1) FOR IsActive
END
GO
