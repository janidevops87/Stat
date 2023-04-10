/***************************************************************************************************
**	Name: TcssListSerologyQuestion
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListSerologyQuestion
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	06/30/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListSerologyQuestion')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListSerologyQuestion'
	ALTER TABLE dbo.TcssListSerologyQuestion ADD CONSTRAINT PK_TcssListSerologyQuestion PRIMARY KEY Clustered (TcssListSerologyQuestionId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSerologyQuestion_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSerologyQuestion_LastUpdateDate'
	ALTER TABLE dbo.TcssListSerologyQuestion ADD CONSTRAINT DF_TcssListSerologyQuestion_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSerologyQuestion_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSerologyQuestion_SortOrder'
	ALTER TABLE dbo.TcssListSerologyQuestion ADD CONSTRAINT DF_TcssListSerologyQuestion_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSerologyQuestion_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSerologyQuestion_IsActive'
	ALTER TABLE dbo.TcssListSerologyQuestion ADD CONSTRAINT DF_TcssListSerologyQuestion_IsActive DEFAULT(1) FOR IsActive
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListSerologyQuestion_ConfigVersion')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListSerologyQuestion_ConfigVersion'
	ALTER TABLE dbo.TcssListSerologyQuestion ADD CONSTRAINT DF_TcssListSerologyQuestion_ConfigVersion DEFAULT(0) FOR ConfigVersion
END
GO
