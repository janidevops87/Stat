/***************************************************************************************************
**	Name: TcssListUrinalysisBacteria
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisBacteria
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisBacteria')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisBacteria'
	ALTER TABLE dbo.TcssListUrinalysisBacteria ADD CONSTRAINT PK_TcssListUrinalysisBacteria PRIMARY KEY Clustered (TcssListUrinalysisBacteriaId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBacteria_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBacteria_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisBacteria ADD CONSTRAINT DF_TcssListUrinalysisBacteria_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBacteria_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBacteria_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisBacteria ADD CONSTRAINT DF_TcssListUrinalysisBacteria_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisBacteria_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisBacteria_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisBacteria ADD CONSTRAINT DF_TcssListUrinalysisBacteria_IsActive DEFAULT(1) FOR IsActive
END
GO
