/***************************************************************************************************
**	Name: TcssListUrinalysisRbc
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisRbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisRbc')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisRbc'
	ALTER TABLE dbo.TcssListUrinalysisRbc ADD CONSTRAINT PK_TcssListUrinalysisRbc PRIMARY KEY Clustered (TcssListUrinalysisRbcId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisRbc_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisRbc_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisRbc ADD CONSTRAINT DF_TcssListUrinalysisRbc_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisRbc_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisRbc_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisRbc ADD CONSTRAINT DF_TcssListUrinalysisRbc_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisRbc_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisRbc_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisRbc ADD CONSTRAINT DF_TcssListUrinalysisRbc_IsActive DEFAULT(1) FOR IsActive
END
GO
