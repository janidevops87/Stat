/***************************************************************************************************
**	Name: TcssListUrinalysisGlucose
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisGlucose
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisGlucose')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisGlucose'
	ALTER TABLE dbo.TcssListUrinalysisGlucose ADD CONSTRAINT PK_TcssListUrinalysisGlucose PRIMARY KEY Clustered (TcssListUrinalysisGlucoseId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisGlucose_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisGlucose_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisGlucose ADD CONSTRAINT DF_TcssListUrinalysisGlucose_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisGlucose_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisGlucose_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisGlucose ADD CONSTRAINT DF_TcssListUrinalysisGlucose_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisGlucose_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisGlucose_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisGlucose ADD CONSTRAINT DF_TcssListUrinalysisGlucose_IsActive DEFAULT(1) FOR IsActive
END
GO
