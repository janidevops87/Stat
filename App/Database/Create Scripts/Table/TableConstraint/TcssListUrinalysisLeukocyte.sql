/***************************************************************************************************
**	Name: TcssListUrinalysisLeukocyte
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisLeukocyte
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisLeukocyte')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisLeukocyte'
	ALTER TABLE dbo.TcssListUrinalysisLeukocyte ADD CONSTRAINT PK_TcssListUrinalysisLeukocyte PRIMARY KEY Clustered (TcssListUrinalysisLeukocyteId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisLeukocyte_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisLeukocyte_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisLeukocyte ADD CONSTRAINT DF_TcssListUrinalysisLeukocyte_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisLeukocyte_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisLeukocyte_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisLeukocyte ADD CONSTRAINT DF_TcssListUrinalysisLeukocyte_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisLeukocyte_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisLeukocyte_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisLeukocyte ADD CONSTRAINT DF_TcssListUrinalysisLeukocyte_IsActive DEFAULT(1) FOR IsActive
END
GO
