/***************************************************************************************************
**	Name: TcssListHlaC2
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaC2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaC2')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaC2'
	ALTER TABLE dbo.TcssListHlaC2 ADD CONSTRAINT PK_TcssListHlaC2 PRIMARY KEY Clustered (TcssListHlaC2Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC2_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC2_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaC2 ADD CONSTRAINT DF_TcssListHlaC2_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC2_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC2_SortOrder'
	ALTER TABLE dbo.TcssListHlaC2 ADD CONSTRAINT DF_TcssListHlaC2_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaC2_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaC2_IsActive'
	ALTER TABLE dbo.TcssListHlaC2 ADD CONSTRAINT DF_TcssListHlaC2_IsActive DEFAULT(1) FOR IsActive
END
GO
