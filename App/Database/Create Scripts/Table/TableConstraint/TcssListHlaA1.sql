/***************************************************************************************************
**	Name: TcssListHlaA1
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaA1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaA1')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaA1'
	ALTER TABLE dbo.TcssListHlaA1 ADD CONSTRAINT PK_TcssListHlaA1 PRIMARY KEY Clustered (TcssListHlaA1Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA1_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA1_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaA1 ADD CONSTRAINT DF_TcssListHlaA1_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA1_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA1_SortOrder'
	ALTER TABLE dbo.TcssListHlaA1 ADD CONSTRAINT DF_TcssListHlaA1_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA1_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA1_IsActive'
	ALTER TABLE dbo.TcssListHlaA1 ADD CONSTRAINT DF_TcssListHlaA1_IsActive DEFAULT(1) FOR IsActive
END
GO
