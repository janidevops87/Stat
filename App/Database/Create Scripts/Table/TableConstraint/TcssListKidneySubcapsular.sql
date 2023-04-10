/***************************************************************************************************
**	Name: TcssListKidneySubcapsular
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidneySubcapsular
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidneySubcapsular')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidneySubcapsular'
	ALTER TABLE dbo.TcssListKidneySubcapsular ADD CONSTRAINT PK_TcssListKidneySubcapsular PRIMARY KEY Clustered (TcssListKidneySubcapsularId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneySubcapsular_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneySubcapsular_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidneySubcapsular ADD CONSTRAINT DF_TcssListKidneySubcapsular_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneySubcapsular_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneySubcapsular_SortOrder'
	ALTER TABLE dbo.TcssListKidneySubcapsular ADD CONSTRAINT DF_TcssListKidneySubcapsular_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidneySubcapsular_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidneySubcapsular_IsActive'
	ALTER TABLE dbo.TcssListKidneySubcapsular ADD CONSTRAINT DF_TcssListKidneySubcapsular_IsActive DEFAULT(1) FOR IsActive
END
GO
