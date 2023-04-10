/***************************************************************************************************
**	Name: TcssListUrinalysisEpith
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisEpith
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisEpith')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisEpith'
	ALTER TABLE dbo.TcssListUrinalysisEpith ADD CONSTRAINT PK_TcssListUrinalysisEpith PRIMARY KEY Clustered (TcssListUrinalysisEpithId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisEpith_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisEpith_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisEpith ADD CONSTRAINT DF_TcssListUrinalysisEpith_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisEpith_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisEpith_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisEpith ADD CONSTRAINT DF_TcssListUrinalysisEpith_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisEpith_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisEpith_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisEpith ADD CONSTRAINT DF_TcssListUrinalysisEpith_IsActive DEFAULT(1) FOR IsActive
END
GO
