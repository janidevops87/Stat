/***************************************************************************************************
**	Name: TcssListUrinalysisProtein
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisProtein
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisProtein')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisProtein'
	ALTER TABLE dbo.TcssListUrinalysisProtein ADD CONSTRAINT PK_TcssListUrinalysisProtein PRIMARY KEY Clustered (TcssListUrinalysisProteinId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisProtein_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisProtein_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisProtein ADD CONSTRAINT DF_TcssListUrinalysisProtein_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisProtein_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisProtein_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisProtein ADD CONSTRAINT DF_TcssListUrinalysisProtein_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisProtein_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisProtein_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisProtein ADD CONSTRAINT DF_TcssListUrinalysisProtein_IsActive DEFAULT(1) FOR IsActive
END
GO
