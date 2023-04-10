/***************************************************************************************************
**	Name: TcssListHeavyAlcoholUse
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHeavyAlcoholUse
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHeavyAlcoholUse')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHeavyAlcoholUse'
	ALTER TABLE dbo.TcssListHeavyAlcoholUse ADD CONSTRAINT PK_TcssListHeavyAlcoholUse PRIMARY KEY Clustered (TcssListHeavyAlcoholUseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeavyAlcoholUse_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeavyAlcoholUse_LastUpdateDate'
	ALTER TABLE dbo.TcssListHeavyAlcoholUse ADD CONSTRAINT DF_TcssListHeavyAlcoholUse_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeavyAlcoholUse_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeavyAlcoholUse_SortOrder'
	ALTER TABLE dbo.TcssListHeavyAlcoholUse ADD CONSTRAINT DF_TcssListHeavyAlcoholUse_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHeavyAlcoholUse_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHeavyAlcoholUse_IsActive'
	ALTER TABLE dbo.TcssListHeavyAlcoholUse ADD CONSTRAINT DF_TcssListHeavyAlcoholUse_IsActive DEFAULT(1) FOR IsActive
END
GO
