/***************************************************************************************************
**	Name: TcssListHlaBw6
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaBw6
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaBw6')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaBw6'
	ALTER TABLE dbo.TcssListHlaBw6 ADD CONSTRAINT PK_TcssListHlaBw6 PRIMARY KEY Clustered (TcssListHlaBw6Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw6_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw6_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaBw6 ADD CONSTRAINT DF_TcssListHlaBw6_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw6_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw6_SortOrder'
	ALTER TABLE dbo.TcssListHlaBw6 ADD CONSTRAINT DF_TcssListHlaBw6_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw6_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw6_IsActive'
	ALTER TABLE dbo.TcssListHlaBw6 ADD CONSTRAINT DF_TcssListHlaBw6_IsActive DEFAULT(1) FOR IsActive
END
GO
