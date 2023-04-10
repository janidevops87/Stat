/***************************************************************************************************
**	Name: TcssListHlaDr1
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDr1
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDr1')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDr1'
	ALTER TABLE dbo.TcssListHlaDr1 ADD CONSTRAINT PK_TcssListHlaDr1 PRIMARY KEY Clustered (TcssListHlaDr1Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr1_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr1_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDr1 ADD CONSTRAINT DF_TcssListHlaDr1_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr1_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr1_SortOrder'
	ALTER TABLE dbo.TcssListHlaDr1 ADD CONSTRAINT DF_TcssListHlaDr1_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr1_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr1_IsActive'
	ALTER TABLE dbo.TcssListHlaDr1 ADD CONSTRAINT DF_TcssListHlaDr1_IsActive DEFAULT(1) FOR IsActive
END
GO
