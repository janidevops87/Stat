/***************************************************************************************************
**	Name: TcssListHlaDr51
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDr51
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDr51')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDr51'
	ALTER TABLE dbo.TcssListHlaDr51 ADD CONSTRAINT PK_TcssListHlaDr51 PRIMARY KEY Clustered (TcssListHlaDr51Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr51_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr51_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDr51 ADD CONSTRAINT DF_TcssListHlaDr51_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr51_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr51_SortOrder'
	ALTER TABLE dbo.TcssListHlaDr51 ADD CONSTRAINT DF_TcssListHlaDr51_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr51_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr51_IsActive'
	ALTER TABLE dbo.TcssListHlaDr51 ADD CONSTRAINT DF_TcssListHlaDr51_IsActive DEFAULT(1) FOR IsActive
END
GO
