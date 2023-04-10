/***************************************************************************************************
**	Name: TcssListT3
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListT3
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListT3')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListT3'
	ALTER TABLE dbo.TcssListT3 ADD CONSTRAINT PK_TcssListT3 PRIMARY KEY Clustered (TcssListT3Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT3_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT3_LastUpdateDate'
	ALTER TABLE dbo.TcssListT3 ADD CONSTRAINT DF_TcssListT3_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT3_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT3_SortOrder'
	ALTER TABLE dbo.TcssListT3 ADD CONSTRAINT DF_TcssListT3_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListT3_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListT3_IsActive'
	ALTER TABLE dbo.TcssListT3 ADD CONSTRAINT DF_TcssListT3_IsActive DEFAULT(1) FOR IsActive
END
GO
