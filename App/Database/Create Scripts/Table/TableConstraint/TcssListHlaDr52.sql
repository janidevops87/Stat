/***************************************************************************************************
**	Name: TcssListHlaDr52
**	Desc: Add Primary keys, Unique keys, and Default Keys to TcssListHlaDr52
****************************************************************************************************
**	Change History
****************************************************************************************************
**	Date			Author			Description
**	----------	------------	--------------------------------------------------------------------
**	08/05/2009	Tanvir Ather	Initial Key Creation 
***************************************************************************************************/

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='K' AND NAME = 'PK_TcssListHlaDr52')
BEGIN
	PRINT 'Creating Primary Key Constraint PK_TcssListHlaDr52'
	ALTER TABLE dbo.TcssListHlaDr52 ADD CONSTRAINT PK_TcssListHlaDr52 PRIMARY KEY Clustered (TcssListHlaDr52Id) --ON Primary
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr52_LastUpdateDate')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr52_LastUpdateDate'
	ALTER TABLE dbo.TcssListHlaDr52 ADD CONSTRAINT DF_TcssListHlaDr52_LastUpdateDate DEFAULT(GetUtcDate()) FOR LastUpdateDate
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr52_SortOrder')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr52_SortOrder'
	ALTER TABLE dbo.TcssListHlaDr52 ADD CONSTRAINT DF_TcssListHlaDr52_SortOrder DEFAULT(1) FOR SortOrder
END
GO

IF NOT EXISTS(SELECT * FROM sysobjects WHERE Type='D' AND NAME = 'DF_TcssListHlaDr52_IsActive')
BEGIN
	PRINT 'Creating Default Constraint DF_TcssListHlaDr52_IsActive'
	ALTER TABLE dbo.TcssListHlaDr52 ADD CONSTRAINT DF_TcssListHlaDr52_IsActive DEFAULT(1) FOR IsActive
END
GO
