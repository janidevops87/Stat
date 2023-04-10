/***************************************************************************************************
**	Name: TcssListHlaDr2
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDr2
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDr2')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDr2'
	ALTER TABLE dbo.TcssListHlaDr2 ADD CONSTRAINT PK_TcssListHlaDr2 PRIMARY KEY Clustered (TcssListHlaDr2Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr2_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr2_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDr2 ADD CONSTRAINT DF_TcssListHlaDr2_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr2_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr2_SortOrder'
	ALTER TABLE dbo.TcssListHlaDr2 ADD CONSTRAINT DF_TcssListHlaDr2_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr2_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr2_IsActive'
	ALTER TABLE dbo.TcssListHlaDr2 ADD CONSTRAINT DF_TcssListHlaDr2_IsActive DEFAULT(1) FOR IsActive
END
GO
