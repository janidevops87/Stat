/***************************************************************************************************
**	Name: TcssListT4
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListT4
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListT4')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListT4'
	ALTER TABLE dbo.TcssListT4 ADD CONSTRAINT PK_TcssListT4 PRIMARY KEY Clustered (TcssListT4Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT4_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT4_LastUpdateDate'
	ALTER TABLE dbo.TcssListT4 ADD CONSTRAINT DF_TcssListT4_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT4_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT4_SortOrder'
	ALTER TABLE dbo.TcssListT4 ADD CONSTRAINT DF_TcssListT4_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT4_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT4_IsActive'
	ALTER TABLE dbo.TcssListT4 ADD CONSTRAINT DF_TcssListT4_IsActive DEFAULT(1) FOR IsActive
END
GO
