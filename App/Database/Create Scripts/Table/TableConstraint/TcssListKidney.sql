/***************************************************************************************************
**	Name: TcssListKidney
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListKidney
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListKidney')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListKidney'
	ALTER TABLE dbo.TcssListKidney ADD CONSTRAINT PK_TcssListKidney PRIMARY KEY Clustered (TcssListKidneyId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidney_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidney_LastUpdateDate'
	ALTER TABLE dbo.TcssListKidney ADD CONSTRAINT DF_TcssListKidney_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidney_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidney_SortOrder'
	ALTER TABLE dbo.TcssListKidney ADD CONSTRAINT DF_TcssListKidney_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListKidney_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListKidney_IsActive'
	ALTER TABLE dbo.TcssListKidney ADD CONSTRAINT DF_TcssListKidney_IsActive DEFAULT(1) FOR IsActive
END
GO
