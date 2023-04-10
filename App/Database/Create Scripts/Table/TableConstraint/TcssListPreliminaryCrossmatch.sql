/***************************************************************************************************
**	Name: TcssListPreliminaryCrossmatch
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListPreliminaryCrossmatch
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListPreliminaryCrossmatch')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListPreliminaryCrossmatch'
	ALTER TABLE dbo.TcssListPreliminaryCrossmatch ADD CONSTRAINT PK_TcssListPreliminaryCrossmatch PRIMARY KEY Clustered (TcssListPreliminaryCrossmatchId) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListPreliminaryCrossmatch_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListPreliminaryCrossmatch_LastUpdateDate'
	ALTER TABLE dbo.TcssListPreliminaryCrossmatch ADD CONSTRAINT DF_TcssListPreliminaryCrossmatch_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListPreliminaryCrossmatch_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListPreliminaryCrossmatch_SortOrder'
	ALTER TABLE dbo.TcssListPreliminaryCrossmatch ADD CONSTRAINT DF_TcssListPreliminaryCrossmatch_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListPreliminaryCrossmatch_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListPreliminaryCrossmatch_IsActive'
	ALTER TABLE dbo.TcssListPreliminaryCrossmatch ADD CONSTRAINT DF_TcssListPreliminaryCrossmatch_IsActive DEFAULT(1) FOR IsActive
END
GO
