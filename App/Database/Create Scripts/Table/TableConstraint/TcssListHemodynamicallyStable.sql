/***************************************************************************************************
**	Name: TcssListHemodynamicallyStable
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHemodynamicallyStable
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	02/17/2010	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHemodynamicallyStable')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHemodynamicallyStable'
	ALTER TABLE dbo.TcssListHemodynamicallyStable ADD CONSTRAINT PK_TcssListHemodynamicallyStable PRIMARY KEY Clustered (TcssListHemodynamicallyStableId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHemodynamicallyStable_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHemodynamicallyStable_LastUpdateDate'
	ALTER TABLE dbo.TcssListHemodynamicallyStable ADD CONSTRAINT DF_TcssListHemodynamicallyStable_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHemodynamicallyStable_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHemodynamicallyStable_SortOrder'
	ALTER TABLE dbo.TcssListHemodynamicallyStable ADD CONSTRAINT DF_TcssListHemodynamicallyStable_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHemodynamicallyStable_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHemodynamicallyStable_IsActive'
	ALTER TABLE dbo.TcssListHemodynamicallyStable ADD CONSTRAINT DF_TcssListHemodynamicallyStable_IsActive DEFAULT(1) FOR IsActive
END
GO
