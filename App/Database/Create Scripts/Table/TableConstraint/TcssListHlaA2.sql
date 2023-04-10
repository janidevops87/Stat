/***************************************************************************************************
**	Name: TcssListHlaA2
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaA2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaA2')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaA2'
	ALTER TABLE dbo.TcssListHlaA2 ADD CONSTRAINT PK_TcssListHlaA2 PRIMARY KEY Clustered (TcssListHlaA2Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA2_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA2_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaA2 ADD CONSTRAINT DF_TcssListHlaA2_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA2_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA2_SortOrder'
	ALTER TABLE dbo.TcssListHlaA2 ADD CONSTRAINT DF_TcssListHlaA2_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaA2_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaA2_IsActive'
	ALTER TABLE dbo.TcssListHlaA2 ADD CONSTRAINT DF_TcssListHlaA2_IsActive DEFAULT(1) FOR IsActive
END
GO
