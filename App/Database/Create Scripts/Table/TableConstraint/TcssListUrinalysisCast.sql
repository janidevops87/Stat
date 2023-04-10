/***************************************************************************************************
**	Name: TcssListUrinalysisCast
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListUrinalysisCast
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListUrinalysisCast')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListUrinalysisCast'
	ALTER TABLE dbo.TcssListUrinalysisCast ADD CONSTRAINT PK_TcssListUrinalysisCast PRIMARY KEY Clustered (TcssListUrinalysisCastId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisCast_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisCast_LastUpdateDate'
	ALTER TABLE dbo.TcssListUrinalysisCast ADD CONSTRAINT DF_TcssListUrinalysisCast_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisCast_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisCast_SortOrder'
	ALTER TABLE dbo.TcssListUrinalysisCast ADD CONSTRAINT DF_TcssListUrinalysisCast_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListUrinalysisCast_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListUrinalysisCast_IsActive'
	ALTER TABLE dbo.TcssListUrinalysisCast ADD CONSTRAINT DF_TcssListUrinalysisCast_IsActive DEFAULT(1) FOR IsActive
END
GO
