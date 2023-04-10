/***************************************************************************************************
**	Name: TcssListAgeUnit
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListAgeUnit
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListAgeUnit')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListAgeUnit'
	ALTER TABLE dbo.TcssListAgeUnit ADD CONSTRAINT PK_TcssListAgeUnit PRIMARY KEY Clustered (TcssListAgeUnitId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAgeUnit_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAgeUnit_LastUpdateDate'
	ALTER TABLE dbo.TcssListAgeUnit ADD CONSTRAINT DF_TcssListAgeUnit_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAgeUnit_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAgeUnit_SortOrder'
	ALTER TABLE dbo.TcssListAgeUnit ADD CONSTRAINT DF_TcssListAgeUnit_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAgeUnit_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAgeUnit_IsActive'
	ALTER TABLE dbo.TcssListAgeUnit ADD CONSTRAINT DF_TcssListAgeUnit_IsActive DEFAULT(1) FOR IsActive
END
GO
