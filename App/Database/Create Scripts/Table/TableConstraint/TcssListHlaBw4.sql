/***************************************************************************************************
**	Name: TcssListHlaBw4
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaBw4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaBw4')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaBw4'
	ALTER TABLE dbo.TcssListHlaBw4 ADD CONSTRAINT PK_TcssListHlaBw4 PRIMARY KEY Clustered (TcssListHlaBw4Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw4_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw4_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaBw4 ADD CONSTRAINT DF_TcssListHlaBw4_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw4_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw4_SortOrder'
	ALTER TABLE dbo.TcssListHlaBw4 ADD CONSTRAINT DF_TcssListHlaBw4_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaBw4_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaBw4_IsActive'
	ALTER TABLE dbo.TcssListHlaBw4 ADD CONSTRAINT DF_TcssListHlaBw4_IsActive DEFAULT(1) FOR IsActive
END
GO
