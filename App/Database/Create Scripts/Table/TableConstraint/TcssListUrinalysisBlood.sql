/***************************************************************************************************
**	Name: TcssListUrinalysisBlood
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisBlood
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisBlood')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisBlood'
	ALTER TABLE dbo.TcssListUrinalysisBlood ADD CONSTRAINT PK_TcssListUrinalysisBlood PRIMARY KEY Clustered (TcssListUrinalysisBloodId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBlood_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBlood_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisBlood ADD CONSTRAINT DF_TcssListUrinalysisBlood_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBlood_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBlood_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisBlood ADD CONSTRAINT DF_TcssListUrinalysisBlood_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBlood_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBlood_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisBlood ADD CONSTRAINT DF_TcssListUrinalysisBlood_IsActive DEFAULT(1) FOR IsActive
END
GO
