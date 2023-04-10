/***************************************************************************************************
**	Name: TcssListHlaC1
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaC1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaC1')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaC1'
	ALTER TABLE dbo.TcssListHlaC1 ADD CONSTRAINT PK_TcssListHlaC1 PRIMARY KEY Clustered (TcssListHlaC1Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC1_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC1_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaC1 ADD CONSTRAINT DF_TcssListHlaC1_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC1_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC1_SortOrder'
	ALTER TABLE dbo.TcssListHlaC1 ADD CONSTRAINT DF_TcssListHlaC1_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC1_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC1_IsActive'
	ALTER TABLE dbo.TcssListHlaC1 ADD CONSTRAINT DF_TcssListHlaC1_IsActive DEFAULT(1) FOR IsActive
END
GO
