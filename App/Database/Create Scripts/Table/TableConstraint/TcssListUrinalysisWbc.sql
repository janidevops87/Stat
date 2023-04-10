/***************************************************************************************************
**	Name: TcssListUrinalysisWbc
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisWbc
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisWbc')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisWbc'
	ALTER TABLE dbo.TcssListUrinalysisWbc ADD CONSTRAINT PK_TcssListUrinalysisWbc PRIMARY KEY Clustered (TcssListUrinalysisWbcId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisWbc_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisWbc_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisWbc ADD CONSTRAINT DF_TcssListUrinalysisWbc_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisWbc_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisWbc_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisWbc ADD CONSTRAINT DF_TcssListUrinalysisWbc_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisWbc_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisWbc_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisWbc ADD CONSTRAINT DF_TcssListUrinalysisWbc_IsActive DEFAULT(1) FOR IsActive
END
GO
