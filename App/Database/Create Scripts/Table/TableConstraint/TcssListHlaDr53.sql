/***************************************************************************************************
**	Name: TcssListHlaDr53
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDr53
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDr53')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDr53'
	ALTER TABLE dbo.TcssListHlaDr53 ADD CONSTRAINT PK_TcssListHlaDr53 PRIMARY KEY Clustered (TcssListHlaDr53Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr53_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr53_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDr53 ADD CONSTRAINT DF_TcssListHlaDr53_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr53_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr53_SortOrder'
	ALTER TABLE dbo.TcssListHlaDr53 ADD CONSTRAINT DF_TcssListHlaDr53_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr53_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr53_IsActive'
	ALTER TABLE dbo.TcssListHlaDr53 ADD CONSTRAINT DF_TcssListHlaDr53_IsActive DEFAULT(1) FOR IsActive
END
GO
