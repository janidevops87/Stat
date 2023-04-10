/***************************************************************************************************
**	Name: TcssListAbo
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListAbo
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListAbo')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListAbo'
	ALTER TABLE dbo.TcssListAbo ADD CONSTRAINT PK_TcssListAbo PRIMARY KEY Clustered (TcssListAboId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAbo_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAbo_LastUpdateDate'
	ALTER TABLE dbo.TcssListAbo ADD CONSTRAINT DF_TcssListAbo_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAbo_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAbo_SortOrder'
	ALTER TABLE dbo.TcssListAbo ADD CONSTRAINT DF_TcssListAbo_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListAbo_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListAbo_IsActive'
	ALTER TABLE dbo.TcssListAbo ADD CONSTRAINT DF_TcssListAbo_IsActive DEFAULT(1) FOR IsActive
END
GO
