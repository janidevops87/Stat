/***************************************************************************************************
**	Name: TcssListCultureResult
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListCultureResult
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListCultureResult')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListCultureResult'
	ALTER TABLE dbo.TcssListCultureResult ADD CONSTRAINT PK_TcssListCultureResult PRIMARY KEY Clustered (TcssListCultureResultId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureResult_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureResult_LastUpdateDate'
	ALTER TABLE dbo.TcssListCultureResult ADD CONSTRAINT DF_TcssListCultureResult_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureResult_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureResult_SortOrder'
	ALTER TABLE dbo.TcssListCultureResult ADD CONSTRAINT DF_TcssListCultureResult_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListCultureResult_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListCultureResult_IsActive'
	ALTER TABLE dbo.TcssListCultureResult ADD CONSTRAINT DF_TcssListCultureResult_IsActive DEFAULT(1) FOR IsActive
END
GO
